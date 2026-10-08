use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

# ── Aanmelden vooraan, de meeting eronder ───────────────────────────────
# Overal stond "Plan een demo" als enige knop. Wie zelf wil beginnen moest
# dus eerst een afspraak in iemands agenda zetten, en dat is een drempel
# die je niet wil op een pagina met een gratis proefperiode.
#
# Nu: de aanmeldknop is de hoofdknop, en wie twijfelt krijgt er een regel
# onder met de meeting. Niet ernaast als tweede knop, want twee knoppen
# naast elkaar laten allebei aan kracht inboeten.
#
# De diepte van de verwijzing verschilt per map (agents/ en koppelingen/
# staan een niveau lager), dus die wordt uit de gevonden link overgenomen
# in plaats van vast ingetypt.

binmode(STDOUT, ':encoding(UTF-8)');

sub lees { my ($p)=@_; open my $f,'<:raw',$p or die "$p: $!"; my $t=decode_utf8(do{local $/;<$f>}); close $f; $t }
sub schrijf { my ($p,$t)=@_; open my $o,'>:raw',$p or die "$p: $!"; print $o encode_utf8($t); close $o }

my $PIJL = '<span class="btn-arrow" aria-hidden="true">&#8594;</span>';

sub twijfelregel {
  my ($op, $inspring) = @_;
  return qq{$inspring<p class="cta-twijfel">Twijfel je nog? <a href="${op}meeting.html">Plan een gesprek van 20 minuten met het team</a></p>};
}

my @BESTANDEN;
for my $map ('.', 'agents', 'koppelingen') {
  opendir(my $d, $map) or next;
  push @BESTANDEN, map { $map eq '.' ? $_ : "$map/$_" } grep { /\.html$/ } readdir $d;
  closedir $d;
}
push @BESTANDEN, 'tools/shell/nav.html', 'tools/shell/footer.html';

my %telling;
for my $pad (sort @BESTANDEN) {
  next unless -f $pad;
  my $t = lees($pad);
  my $voor = $t;
  my $E = ($t =~ /\r\n/) ? "\r\n" : "\n";

  # 1. De kleine knop in de kop: gewoon van doel en tekst wisselen.
  $telling{'menuknop'} += ($t =~ s{<a href="((?:\.\./)*)meeting\.html" class="btn">Plan een demo</a>}
                                  {<a href="$1aanmelden.html" class="btn">Probeer Helvaro gratis</a>}g);

  # 2. Grote knoppen in een actiegroep: knop omzetten, en de twijfelregel
  #    NA het sluiten van de groep zetten. Binnen de groep zou hij in de
  #    rij naast de knoppen belanden.
  for my $groep (qw(hero-acties paghero-acties pilot-acties footer-cta)) {
    $telling{$groep} += ($t =~ s{
        (<div\ class="\Q$groep\E">)          # 1 opening
        (.*?)                                 # 2 inhoud
        <a\ href="((?:\.\./)*)meeting\.html"\ class="btn\ btn-lg">Plan\ een\ demo\ \Q$PIJL\E</a>
        (.*?)                                 # 4 rest
        (\r?\n)([ \t]*)</div>                 # 5 regeleinde, 6 inspringing
      }{
        my ($open, $inhoud, $op, $rest, $nl, $in) = ($1, $2, $3, $4, $5, $6);
        $open . $inhoud
          . qq{<a href="${op}aanmelden.html" class="btn btn-lg">Start gratis $PIJL</a>}
          . $rest . $nl . $in . '</div>' . $nl . twijfelregel($op, $in)
      }gsex);
  }

  # 3. De band onderaan een pagina: daar staat de knop los, dus de regel
  #    mag er direct achter.
  $telling{'cta-band'} += ($t =~ s{
      <a\ href="((?:\.\./)*)meeting\.html"\ class="btn\ btn-lg\ reveal\ reveal-delay-2">Plan\ een\ demo\ \Q$PIJL\E</a>
      (\r?\n)([ \t]*)
    }{
      my ($op, $nl, $in) = ($1, $2, $3);
      qq{<a href="${op}aanmelden.html" class="btn btn-lg reveal reveal-delay-2">Start gratis $PIJL</a>}
        . $nl . twijfelregel($op, $in) . $nl . $in
    }gsex);

  # 4. De tekstlink in de voet mag blijven, maar heet nu naar wat hij is.
  $telling{'voetlink'} += ($t =~ s{<a href="((?:\.\./)*)meeting\.html" class="footer-link">Plan een demo</a>}
                                  {<a href="$1meeting.html" class="footer-link">Plan een gesprek</a>}g);

  next if $t eq $voor;
  schrijf($pad, $t);
}

print "Omgezet:\n";
printf "  %-16s %4d\n", $_, ($telling{$_} || 0) for qw(menuknop hero-acties paghero-acties pilot-acties footer-cta cta-band voetlink);
