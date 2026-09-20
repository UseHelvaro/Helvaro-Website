#!/usr/bin/perl
# ============================================================================
# sync-shell.pl — één navigatie en één voettekst over alle Nederlandse pagina's
# ----------------------------------------------------------------------------
# De site heeft geen bouwstap voor HTML: elke pagina draagt haar eigen kop en
# voet. Met acht pagina's was dat te doen. Met dertig niet meer: één link
# toevoegen betekende dertig bestanden bewerken, en dan loopt het uit elkaar.
#
# Daarom staat de kop in tools/shell/nav.html en de voet in
# tools/shell/footer.html, geschreven alsof ze in de hoofdmap staan. Dit
# script zet ze in elke pagina tussen de merktekens:
#
#   <!-- SHELL:NAV -->   ... <!-- /SHELL:NAV -->
#   <!-- SHELL:FOOTER -->... <!-- /SHELL:FOOTER -->
#
# Alles tussen die merktekens is dus gegenereerd. Bewerk het daar niet, want
# de volgende sync gooit het weg. Bewerk tools/shell/.
#
# Paden worden per pagina verdiept. agents/apk-herinnering-agent.html zit één
# map diep, dus index.html wordt ../index.html. Absolute paden, #ankers,
# mailto: en http(s): blijven met rust: de taalkiezer heeft absolute paden
# nodig en build-langs.pl rekent daarop.
#
# Gebruik
#   perl tools/sync-shell.pl            alle pagina's
#   perl tools/sync-shell.pl index.html alleen die ene
# ============================================================================
use strict;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

sub lees {
  my ($pad) = @_;
  open my $fh, '<:raw', $pad or die "$pad: $!\n";
  my $t = decode_utf8(do { local $/; <$fh> });
  close $fh;
  return $t;
}

my $NAV  = lees('tools/shell/nav.html');
my $FOOT = lees('tools/shell/footer.html');

# De kopregel met de uitleg hoort in de bron, niet in elke pagina.
for ($NAV, $FOOT) { s{^<!--.*?-->\s*}{}s; }

# Pagina's met een kop en een voet. 404.html staat er bewust niet bij: die
# heeft er geen, en dat is daar de bedoeling.
my @PAGES = qw(
  index.html systeem.html automotive.html roi.html cases.html
  waarom.html contact.html meeting.html aanmelden.html privacybeleid.html
  sectoren/vastgoed.html sectoren/bouw.html
  agents/index.html
  agents/apk-herinnering-agent.html
  agents/werkplaats-inplan-agent.html
  agents/gemiste-gesprekken-agent.html
  agents/offerte-opvolg-agent.html
  agents/no-show-agent.html
  agents/onderdelen-navraag-agent.html
  agents/leenauto-agent.html
  agents/schade-intake-agent.html
  agents/winterbanden-oproep-agent.html
  agents/onderhoudsbeurt-herinnering-agent.html
  koppelingen/index.html
  koppelingen/automaat-go.html
  koppelingen/autoflex.html
  koppelingen/wincar.html
  koppelingen/rdw-kenteken.html
);

@PAGES = @ARGV if @ARGV;

# ── Paden verdiepen ─────────────────────────────────────────────────────────
# Alleen relatieve paden. Wat absoluut is of naar buiten wijst, blijft staan.
sub verdiep {
  my ($html, $diep) = @_;
  return $html if $diep == 0;
  my $op = '../' x $diep;
  for my $attr (qw(href src srcset)) {
    $html =~ s{(\b$attr=")(?!https?:|//|/|\#|mailto:|tel:)([^"]*)(")}{$1$op$2$3}g;
  }
  return $html;
}

my ($geraakt, $overgeslagen, $zonder) = (0, 0, 0);

for my $pagina (@PAGES) {
  unless (-f $pagina) {
    printf "  %-46s bestaat nog niet\n", $pagina;
    $overgeslagen++;
    next;
  }

  my $html = lees($pagina);
  my $diep = ($pagina =~ tr{/}{});

  my $nav  = verdiep($NAV,  $diep);
  my $foot = verdiep($FOOT, $diep);

  my $veranderd = 0;
  my $mist = 0;

  if ($html =~ m{<!-- SHELL:NAV -->.*?<!-- /SHELL:NAV -->}s) {
    my $nieuw = "<!-- SHELL:NAV -->\n$nav<!-- /SHELL:NAV -->";
    my $oud = $&;
    if ($oud ne $nieuw) { $html =~ s{\Q$oud\E}{$nieuw}s; $veranderd = 1; }
  } else { $mist = 1; }

  if ($html =~ m{<!-- SHELL:FOOTER -->.*?<!-- /SHELL:FOOTER -->}s) {
    my $nieuw = "<!-- SHELL:FOOTER -->\n$foot<!-- /SHELL:FOOTER -->";
    my $oud = $&;
    if ($oud ne $nieuw) { $html =~ s{\Q$oud\E}{$nieuw}s; $veranderd = 1; }
  } else { $mist = 1; }

  if ($mist) {
    printf "  %-46s GEEN merktekens, niets gedaan\n", $pagina;
    $zonder++;
    next;
  }

  if ($veranderd) {
    open my $o, '>:raw', $pagina or die "$pagina: $!\n";
    print $o encode_utf8($html);
    close $o;
    printf "  %-46s bijgewerkt\n", $pagina;
    $geraakt++;
  }
}

print "\n$geraakt pagina's bijgewerkt.\n";
print "$overgeslagen bestaan nog niet.\n" if $overgeslagen;
print "$zonder zonder merktekens.\n"      if $zonder;
