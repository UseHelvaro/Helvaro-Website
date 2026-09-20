#!/usr/bin/perl
# ============================================================================
# voeg-vertalingen.pl — zet een tabelbestand om in vier taalbestanden
# ----------------------------------------------------------------------------
# Vertalen gaat het snelst als de vier talen naast elkaar staan: je leest de
# Nederlandse zin één keer en schrijft er vier vertalingen bij, met dezelfde
# termen. Vier losse JavaScript-bestanden bijwerken nodigt uit tot verschillen.
#
# Invoer is een tabbestand met vijf kolommen:
#
#   nederlands <TAB> frans <TAB> engels <TAB> duits <TAB> spaans
#
# Regels die leeg zijn of met # beginnen worden overgeslagen. Een lege kolom
# betekent: nog geen vertaling, laat die zin in het Nederlands staan.
#
# Gebruik
#   perl tools/voeg-vertalingen.pl tools/vert/blok-01.txt
#   perl tools/voeg-vertalingen.pl tools/vert/*.txt
#
# Daarna tools/build-langs.pl draaien om de pagina's opnieuw te bouwen.
# ============================================================================
use strict;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

my @LANGS = qw(fr en de es);

die "Gebruik: perl tools/voeg-vertalingen.pl <tabbestand> [...]\n" unless @ARGV;

my %NIEUW = map { $_ => {} } @LANGS;
my ($regels, $overgeslagen) = (0, 0);

for my $bestand (@ARGV) {
  open my $fh, '<:raw', $bestand or die "$bestand: $!\n";
  my $ruw = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my $nr = 0;
  for my $regel (split /\r?\n/, $ruw) {
    $nr++;
    next if $regel =~ /^\s*$/;
    next if $regel =~ /^\s*#/;

    my @kol = split /\t/, $regel, 5;
    unless (@kol == 5) {
      warn "$bestand regel $nr: $.".scalar(@kol)." kolommen in plaats van 5, overgeslagen\n";
      $overgeslagen++;
      next;
    }

    my $nl = shift @kol;
    next if $nl =~ /^\s*$/;
    $regels++;

    for my $i (0 .. $#LANGS) {
      my $v = $kol[$i];
      next if !defined $v || $v =~ /^\s*$/;
      $NIEUW{ $LANGS[$i] }{$nl} = $v;
    }
  }
}

# JavaScript-string. Alleen backslash, aanhalingsteken en regeleinde hoeven
# aandacht; de rest van de tekens gaan als UTF-8 het bestand in.
sub js {
  my ($t) = @_;
  $t =~ s/\\/\\\\/g;
  $t =~ s/"/\\"/g;
  $t =~ s/\n/\\n/g;
  $t =~ s/\r//g;
  return '"' . $t . '"';
}

for my $lang (@LANGS) {
  my $paren = $NIEUW{$lang};
  my $n = scalar keys %$paren;
  unless ($n) { printf "  %s  niets toe te voegen\n", $lang; next; }

  my $pad = "js/lang/$lang.js";
  open my $fh, '<:raw', $pad or die "$pad: $!\n";
  my $bestaand = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my $blok = "\n\nObject.assign(window.HELVARO_TR['$lang'], {\n";
  my @stukken;
  for my $nl (sort keys %$paren) {
    push @stukken, '  ' . js($nl) . ': ' . js($paren->{$nl});
  }
  $blok .= join(",\n", @stukken) . "\n});\n";

  $bestaand =~ s/\s+\z//;
  open my $o, '>:raw', $pad or die "$pad: $!\n";
  print $o encode_utf8($bestaand . $blok);
  close $o;

  printf "  %s  %4d vertalingen toegevoegd\n", $lang, $n;
}

printf "\n%d regels gelezen%s.\n", $regels,
  ($overgeslagen ? ", $overgeslagen overgeslagen" : '');
