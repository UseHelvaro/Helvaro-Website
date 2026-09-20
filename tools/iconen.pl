#!/usr/bin/perl
# ============================================================================
# iconen.pl — eigen lijniconen in plaats van emoji
# ----------------------------------------------------------------------------
# Emoji zien er op elk toestel anders uit: op een iPhone een glanzende
# kalender met "JUL 17", op Windows iets heel anders. Naast de rustige
# Sand Black-stijl vielen ze op als stickers. Deze iconen zijn in dezelfde
# lijnstijl getekend als de wereldbol en de maan in de navigatie: 24 bij 24,
# lijndikte 1.8, afgeronde uiteinden, kleur via currentColor.
#
# Het script vervangt emoji die als icoon dienen door de SVG hieronder. Emoji
# in de chatberichten zelf blijven staan: dat zijn de woorden van een klant.
#
# Gebruik
#   perl tools/iconen.pl
# ============================================================================
use strict;
use utf8;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

sub svg {
  my ($binnen) = @_;
  return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" '
       . 'stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' . $binnen . '</svg>';
}

my %ICOON = (
  # telefoon
  "\x{1F4DE}" => svg('<path d="M5 4h3.5l1.5 4-2 1.5a11 11 0 0 0 6.5 6.5l1.5-2 4 1.5V19a1.5 1.5 0 0 1-1.5 1.5A15.5 15.5 0 0 1 3.5 5.5 1.5 1.5 0 0 1 5 4z"/>'),
  # berichtje
  "\x{1F4AC}" => svg('<path d="M20 12a7.5 7.5 0 0 1-11.2 6.5L4 20l1.5-4.3A7.5 7.5 0 1 1 20 12z"/><path d="M9 12h.01M12.5 12h.01M16 12h.01"/>'),
  # website
  "\x{1F310}" => svg('<rect x="3" y="4.5" width="18" height="15" rx="2.5"/><path d="M3 9h18"/><path d="M6.5 6.8h.01M9 6.8h.01"/>'),
  # formulier
  "\x{1F4DD}" => svg('<path d="M14 3.5H7A2 2 0 0 0 5 5.5v13a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-10z"/><path d="M14 3.5v5h5"/><path d="M8.5 13h7M8.5 16.5h4.5"/>'),
  # afspraak
  "\x{1F4C5}" => svg('<rect x="3.5" y="5" width="17" height="15.5" rx="2.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/><path d="M9 14.5l2 2 4-4"/>'),
  # planning, een steeksleutel
  "\x{1F527}" => svg('<path d="M14.5 6.5a4 4 0 0 1 5-3.4l-2.7 2.7.6 2.2 2.2.6 2.7-2.7a4 4 0 0 1-5.4 4.8L9.2 18.4a2.1 2.1 0 0 1-3-3L13 8.6a4 4 0 0 1 1.5-2.1z"/>'),
  # auto
  "\x{1F697}" => svg('<path d="M4 16.5V12l2-5a2 2 0 0 1 1.9-1.3h8.2A2 2 0 0 1 18 7l2 5v4.5"/><path d="M3 16.5h18M4 12h16"/><circle cx="7.5" cy="16.5" r="1.8"/><circle cx="16.5" cy="16.5" r="1.8"/>'),
  # omzet, een stijgende lijn
  "\x{1F4C8}" => svg('<path d="M4 19.5h16"/><path d="M5 15.5l4.5-4.5 3.5 3.5L19.5 8"/><path d="M15 8h4.5v4.5"/>'),
  # kenteken herkend, een bliksem
  "\x{26A1}"  => svg('<path d="M13 3L5 13.5h6L10 21l8-10.5h-6z"/>'),
);

my @PAGINAS = qw(index.html systeem.html);

my $totaal = 0;
for my $p (@PAGINAS) {
  open my $fh, '<:raw', $p or die "$p: $!";
  my $h = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my $n = 0;
  # Alleen binnen de icoonvakjes, nergens anders.
  $h =~ s{(<(?:span|div) class="(?:stroom-icoon|chip-icon)"[^>]*>)\s*([^<]+?)\s*(</(?:span|div)>)}{
    my ($open, $inhoud, $dicht) = ($1, $2, $3);
    (my $sleutel = $inhoud) =~ s/\x{FE0F}//g;
    if (exists $ICOON{$sleutel}) { $n++; $open . $ICOON{$sleutel} . $dicht }
    else { $open . $inhoud . $dicht }
  }ge;

  open my $o, '>:raw', $p or die "$p: $!";
  print $o encode_utf8($h);
  close $o;
  printf "  %-16s %2d iconen\n", $p, $n;
  $totaal += $n;
}
print "\n$totaal emoji vervangen.\n";
