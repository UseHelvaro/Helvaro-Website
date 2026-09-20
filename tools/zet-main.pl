#!/usr/bin/perl
# ============================================================================
# zet-main.pl — vervangt de inhoud van <main> in een pagina
# ----------------------------------------------------------------------------
# De kop en de voet staan al goed door nieuwe-paginas.pl en sync-shell.pl.
# Dit zet alleen het middenstuk erin, zodat de inhoud in een los bestand
# geschreven kan worden zonder de rest van de pagina aan te raken.
#
# Gebruik
#   perl tools/zet-main.pl pagina.html inhoud.html
# ============================================================================
use strict;
use warnings;
use Encode qw(decode_utf8 encode_utf8);

my ($pagina, $inhoud) = @ARGV;
die "Gebruik: perl tools/zet-main.pl <pagina.html> <inhoud.html>\n"
  unless $pagina && $inhoud;

sub lees {
  my ($p) = @_;
  open my $fh, '<:raw', $p or die "$p: $!\n";
  my $t = decode_utf8(do { local $/; <$fh> });
  close $fh;
  return $t;
}

my $html = lees($pagina);
my $mid  = lees($inhoud);

$html =~ s{(<main id="main">).*?(\n  </main>)}{$1\n$mid$2}s
  or die "$pagina: geen <main id=\"main\"> gevonden\n";

open my $o, '>:raw', $pagina or die "$pagina: $!\n";
print $o encode_utf8($html);
close $o;

my $n = () = $mid =~ /\n/g;
printf "  %-48s %4d regels inhoud\n", $pagina, $n;
