#!/usr/bin/perl
# ============================================================================
# herstel-tekens.pl — repareert dubbel gecodeerde tekens
# ----------------------------------------------------------------------------
# Wat er misging: een perl-script met losse UTF-8 in de broncode maar zonder
# "use utf8" leest die tekens als losse bytes. Gaat het resultaat daarna door
# encode_utf8, dan wordt elke byte nog een keer gecodeerd. Een "é" wordt dan
# "Ã©", en dat is precies wat er in de tekstballon van Faro stond.
#
# Dit script draait het terug. Het zoekt reeksen tekens uit het Latin-1-bereik
# die samen geldige UTF-8 vormen, en vervangt ze door het teken dat er hoort te
# staan. Een losse "é" of een middenstip blijft met rust: die vormen in hun
# eentje geen geldige UTF-8 en worden dus niet aangeraakt.
#
# Gebruik
#   perl tools/herstel-tekens.pl --kijk    laat zien wat er zou veranderen
#   perl tools/herstel-tekens.pl           voert het uit
# ============================================================================
use strict;
use utf8;   # tekens in dit bestand zijn tekens, geen losse bytes
use warnings;
use Encode qw(decode encode decode_utf8 encode_utf8);
use File::Find;

my $KIJK = grep { $_ eq '--kijk' } @ARGV;

my @bestanden;
find(sub {
  return unless -f $_;
  return if $File::Find::name =~ m{/\.git/};
  return unless /\.(html|js|css|md|pl|sh|txt|xml|json)$/;
  # Dit script noemt de kapotte tekens zelf als voorbeeld in zijn uitleg.
  # Zonder deze regel repareert het zijn eigen documentatie stuk.
  return if $File::Find::name =~ m{herstel-tekens\.pl$};
  push @bestanden, $File::Find::name;
}, '.');

my ($geraakt, $totaal) = (0, 0);

for my $pad (sort @bestanden) {
  open my $fh, '<:raw', $pad or next;
  my $ruw = do { local $/; <$fh> };
  close $fh;

  my $tekst = eval { decode('UTF-8', $ruw, Encode::FB_CROAK) };
  next unless defined $tekst;      # geen geldige UTF-8, laat staan

  my $n = 0;
  my @gevonden;

  # Een reeks tekens die allemaal in Latin-1 passen. Vormen die samen geldige
  # UTF-8 voor iets dat geen ASCII is, dan is het dubbel gecodeerd.
  #
  # Het bereik begint bij 0080 en niet bij 00A0. Een apostrof (U+2019) wordt
  # dubbel gecodeerd namelijk "â" gevolgd door twee tekens uit 0080-009F, en
  # die vallen anders buiten de zoekopdracht. In gewone tekst komen die tekens
  # niet voor, dus dat kost niets.
  $tekst =~ s{([\x{0080}-\x{00FF}]{2,6})}{
    my $reeks = $1;
    my $bytes = encode('ISO-8859-1', $reeks);
    my $terug = eval { decode('UTF-8', $bytes, Encode::FB_CROAK) };
    if (defined $terug && $terug ne $reeks && $terug !~ /[\x00-\x1F]/) {
      $n++;
      push @gevonden, [$reeks, $terug] if @gevonden < 4;
      $terug;
    } else {
      $reeks;
    }
  }ge;

  next unless $n;

  $geraakt++;
  $totaal += $n;
  printf "  %-46s %3d hersteld\n", $pad, $n;
  for my $g (@gevonden) {
    printf "      %s  ->  %s\n", encode_utf8($g->[0]), encode_utf8($g->[1]);
  }

  next if $KIJK;

  open my $uit, '>:raw', $pad or die "$pad: $!";
  print $uit encode_utf8($tekst);
  close $uit;
}

printf "\n%d tekens in %d bestanden%s.\n",
  $totaal, $geraakt, ($KIJK ? ' (alleen gekeken)' : ' hersteld');

# In de bouwstap draait dit met --kijk. Vindt het iets, dan stopt de build:
# kapotte tekens horen daar te sneuvelen, niet in de tekstballon op iemands
# telefoon.
exit($KIJK && $totaal ? 1 : 0);
