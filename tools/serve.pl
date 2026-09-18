#!/usr/bin/perl
# ============================================================================
# serve.pl — kleine statische webserver om de site lokaal te bekijken
# ----------------------------------------------------------------------------
# Er staat geen Node, Python, PHP of Ruby op deze machine, en de
# voorbeeldweergave kan geen JavaScript draaien op een file://-adres. Zonder
# server is de site dus alleen te zien nadat hij online staat, en dat is een
# trage manier om opmaak te controleren.
#
# Perl heeft sockets in de kern, dus een server van honderd regels volstaat.
# Geen afhankelijkheden, niets te installeren.
#
# Gebruik
#   perl tools/serve.pl 8080
#   daarna http://localhost:8080 openen
#
# Alleen voor lokaal kijken. Dit is geen productieserver: één verzoek
# tegelijk, en hij serveert enkel uit de map waarin hij start.
# ============================================================================
use strict;
use warnings;
use IO::Socket::INET;

my $poort = shift(@ARGV) || 8080;
my $wortel = do { require Cwd; Cwd::getcwd() };

my %MIME = (
  html => 'text/html; charset=utf-8',  htm  => 'text/html; charset=utf-8',
  css  => 'text/css; charset=utf-8',   js   => 'text/javascript; charset=utf-8',
  json => 'application/json',          xml  => 'application/xml',
  svg  => 'image/svg+xml',             png  => 'image/png',
  jpg  => 'image/jpeg',                jpeg => 'image/jpeg',
  webp => 'image/webp',                gif  => 'image/gif',
  ico  => 'image/x-icon',              txt  => 'text/plain; charset=utf-8',
  woff => 'font/woff',                 woff2=> 'font/woff2',
  mp4  => 'video/mp4',                 webm => 'video/webm',
  pdf  => 'application/pdf',           md   => 'text/markdown; charset=utf-8',
);

my $server = IO::Socket::INET->new(
  LocalAddr => '127.0.0.1',
  LocalPort => $poort,
  Proto     => 'tcp',
  Listen    => 32,
  ReuseAddr => 1,
) or die "Kan poort $poort niet openen: $!\n";

$| = 1;
print "Helvaro staat op http://localhost:$poort\n";
print "Map: $wortel\n";
print "Stoppen met Ctrl-C.\n";

sub stuur {
  my ($klant, $status, $type, $body, $extra) = @_;
  my $len = length $body;
  print $klant "HTTP/1.1 $status\r\n";
  print $klant "Content-Type: $type\r\n";
  print $klant "Content-Length: $len\r\n";
  print $klant "Cache-Control: no-store\r\n";   # altijd de verse versie
  print $klant $extra if $extra;
  print $klant "Connection: close\r\n\r\n";
  print $klant $body;
}

while (my $klant = $server->accept) {
  my $regel = <$klant>;
  unless (defined $regel) { close $klant; next; }

  # De rest van de kop overslaan.
  while (my $k = <$klant>) { last if $k =~ /^\r?\n$/ }

  my ($methode, $pad) = $regel =~ m{^(\w+)\s+(\S+)};
  unless ($methode && $pad) { close $klant; next; }

  $pad =~ s/\?.*$//;                 # querystring eraf
  $pad =~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/ge;
  $pad =~ s{\.\.}{}g;                # nooit boven de wortel uit
  $pad = '/index.html' if $pad eq '/';
  $pad .= 'index.html' if $pad =~ m{/$};

  my $bestand = $wortel . $pad;
  $bestand =~ s{/}{\\}g if $^O =~ /MSWin/;

  if (-d $bestand) {
    $bestand .= ($^O =~ /MSWin/ ? '\\index.html' : '/index.html');
  }

  if (-f $bestand && open my $fh, '<:raw', $bestand) {
    my $body = do { local $/; <$fh> };
    close $fh;
    my ($ext) = $bestand =~ /\.([A-Za-z0-9]+)$/;
    my $type = $MIME{ lc($ext || '') } || 'application/octet-stream';
    stuur($klant, '200 OK', $type, $body);
    printf "  200  %s\n", $pad;
  } else {
    # Net als Vercel: onbekend pad krijgt de eigen 404-pagina.
    my $vier = $wortel . ($^O =~ /MSWin/ ? '\\404.html' : '/404.html');
    if (-f $vier && open my $fh, '<:raw', $vier) {
      my $body = do { local $/; <$fh> }; close $fh;
      stuur($klant, '404 Not Found', 'text/html; charset=utf-8', $body);
    } else {
      stuur($klant, '404 Not Found', 'text/plain; charset=utf-8', "Niet gevonden: $pad\n");
    }
    printf "  404  %s\n", $pad;
  }
  close $klant;
}
