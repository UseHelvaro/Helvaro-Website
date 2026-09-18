#!/usr/bin/perl
# Schrijft sitemap.xml met alle vijf de talen en hun onderlinge hreflang.
# Draai dit na tools/build-langs.pl.
use strict; use warnings;

my $BASE  = 'https://helvaro.pro';
my @LANGS = qw(nl fr en de es);
my @PAGES = (
  ['',                      '1.0', 'weekly'],
  ['waarom.html',           '0.8', 'monthly'],
  ['sectoren/vastgoed.html','0.7', 'monthly'],
  ['sectoren/bouw.html',    '0.7', 'monthly'],
  ['meeting.html',          '0.7', 'monthly'],
  ['contact.html',          '0.6', 'monthly'],
  ['aanmelden.html',        '0.6', 'monthly'],
  ['privacybeleid.html',    '0.3', 'yearly'],
);

sub url_voor { my ($l,$p)=@_; return $l eq 'nl' ? "$BASE/$p" : "$BASE/$l/$p"; }

my $xml = qq{<?xml version="1.0" encoding="UTF-8"?>\n};
$xml .= qq{<urlset xmlns="http://www.sitemap.org/schemas/sitemap/0.9"\n};
$xml =~ s{www\.sitemap\.org}{www.sitemaps.org};
$xml .= qq{        xmlns:xhtml="http://www.w3.org/1999/xhtml">\n};

for my $p (@PAGES) {
  my ($pad, $prio, $freq) = @$p;
  for my $l (@LANGS) {
    $xml .= "  <url>\n    <loc>" . url_voor($l, $pad) . "</loc>\n";
    for my $alt (@LANGS) {
      $xml .= qq{    <xhtml:link rel="alternate" hreflang="$alt" href="} . url_voor($alt, $pad) . qq{"/>\n};
    }
    $xml .= qq{    <xhtml:link rel="alternate" hreflang="x-default" href="} . url_voor('nl', $pad) . qq{"/>\n};
    $xml .= "    <changefreq>$freq</changefreq>\n    <priority>$prio</priority>\n  </url>\n";
  }
}
$xml .= "</urlset>\n";

open my $o, '>:raw', 'sitemap.xml' or die $!;
print $o $xml; close $o;
printf "sitemap.xml: %d URL's over %d talen.\n", scalar(@PAGES) * scalar(@LANGS), scalar(@LANGS);
