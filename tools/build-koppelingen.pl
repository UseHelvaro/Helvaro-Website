#!/usr/bin/perl
# ============================================================================
# build-koppelingen.pl — schrijft de koppelingspagina's uit één sjabloon
# ----------------------------------------------------------------------------
# Zelfde idee als tools/build-agents.pl. De inhoud staat in
# tools/koppelingen-data.pl, de opbouw hier.
#
# LET OP bij het bijwerken van de status. "live" betekent: het draait bij een
# echte garage en je kunt het in een demo laten zien. Alles daarvoor is "bouw"
# of "plan". Deze pagina's zijn het enige plek waar we dat onderscheid
# uitleggen, dus hier gokken ondermijnt de rest van de site.
#
# Gebruik
#   perl tools/build-koppelingen.pl
# ============================================================================
use strict;
use utf8;   # tekens in dit bestand zijn tekens, geen losse bytes
use warnings;
use Encode qw(decode_utf8 encode_utf8);

my $DATA = do './tools/koppelingen-data.pl';
die "tools/koppelingen-data.pl: $@\n" if $@;
die "tools/koppelingen-data.pl gaf niets terug\n" unless ref $DATA eq 'ARRAY';

my %LABEL = (
  live => 'live',
  bouw => 'in ontwikkeling',
  plan => 'gepland',
);

sub e {
  my ($t) = @_;
  return '' unless defined $t;
  $t =~ s/&/&amp;/g; $t =~ s/</&lt;/g; $t =~ s/>/&gt;/g;
  return $t;
}
sub r { my ($t) = @_; return defined $t ? $t : '' }

sub blok {
  my ($k) = @_;
  my $status = $k->{status};
  my $label  = $LABEL{$status} or die "onbekende status: $status\n";

  my $h = '';

  $h .= qq{    <section class="paghero" data-gids="hero">\n};
  $h .= qq{      <div class="paghero-bg" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <nav class="kruimels" aria-label="Kruimelpad">\n};
  $h .= qq{          <a href="../index.html">Home</a>\n          <span aria-hidden="true">\x{00B7}</span>\n};
  $h .= qq{          <a href="index.html">Koppelingen</a>\n          <span aria-hidden="true">\x{00B7}</span>\n};
  $h .= qq{          <span aria-current="page">} . e($k->{naam}) . qq{</span>\n        </nav>\n};
  $h .= qq{        <div class="paghero-status">\n};
  $h .= qq{          <span class="section-label">Koppeling</span>\n};
  $h .= qq{          <span class="status-pil status-$status">$label</span>\n};
  $h .= qq{        </div>\n};
  $h .= qq{        <h1 class="paghero-titel">} . r($k->{h1}) . qq{</h1>\n};
  $h .= qq{        <p class="paghero-lede">} . r($k->{lede}) . qq{</p>\n};
  $h .= qq{        <div class="paghero-acties">\n};
  $h .= qq{          <a href="../meeting.html" class="btn btn-lg">Plan een demo <span class="btn-arrow" aria-hidden="true">&#8594;</span></a>\n};
  $h .= qq{          <a href="index.html" class="btn btn-ghost btn-lg">Alle koppelingen</a>\n};
  $h .= qq{        </div>\n      </div>\n    </section>\n\n};

  # ── Waar Helvaro zit ───────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="stapel">\n      <div class="container">\n};
  $h .= qq{        <div class="section-header text-center reveal">\n};
  $h .= qq{          <span class="section-label">De plek in de stapel</span>\n};
  $h .= qq{          <h2 class="section-title">Waar dit zit in je bedrijf.</h2>\n};
  $h .= qq{          <p class="section-sub">Helvaro vervangt je pakket niet. Het staat ervoor, op de plek waar nu niemand staat.</p>\n};
  $h .= qq{        </div>\n};
  $h .= qq{        <div class="stapel reveal">\n};
  my @lagen = (
    ['De klant',      $k->{stapel}{klant}],
    ['Helvaro',       $k->{stapel}{helvaro}],
    [$k->{naam},      $k->{stapel}{pakket}],
    ['De werkplaats', $k->{stapel}{werkplaats}],
  );
  my $i = 0;
  for my $l (@lagen) {
    $i++;
    my $merk = $i == 2 ? ' stapel-rij-kern' : '';
    $h .= qq{          <div class="stapel-rij$merk">\n};
    $h .= qq{            <span class="stapel-naam">} . e($l->[0]) . qq{</span>\n};
    $h .= qq{            <span class="stapel-wat">} . r($l->[1]) . qq{</span>\n};
    $h .= qq{          </div>\n};
    $h .= qq{          <div class="stapel-pijl" aria-hidden="true">&#8595;</div>\n} if $i < @lagen;
  }
  $h .= qq{        </div>\n      </div>\n    </section>\n\n};

  # ── Wat de koppeling doet ──────────────────────────────────────────────
  my $kop_doet = $status eq 'live' ? 'Wat de koppeling doet.' : 'Wat de koppeling gaat doen.';
  $h .= qq{    <section class="section" data-gids="doet">\n};
  $h .= qq{      <div class="section-glow" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <div class="section-header text-center reveal">\n};
  $h .= qq{          <span class="section-label">Opzet</span>\n};
  $h .= qq{          <h2 class="section-title">$kop_doet</h2>\n};
  $h .= qq{        </div>\n        <div class="duo-grid">\n};
  my $j = 0;
  for my $d (@{ $k->{doet} }) {
    $j++;
    my $vert = $j > 2 ? ' reveal-delay-1' : '';
    $h .= qq{          <div class="duo-kaart reveal$vert spot">\n};
    $h .= qq{            <h3 class="duo-titel">} . r($d->{titel}) . qq{</h3>\n};
    $h .= qq{            <p class="duo-desc">} . r($d->{tekst}) . qq{</p>\n};
    $h .= qq{          </div>\n};
  }
  $h .= qq{        </div>\n      </div>\n    </section>\n\n};

  # ── Stand van zaken ────────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="stand">\n      <div class="container">\n};
  $h .= qq{        <div class="stand-kaart reveal">\n};
  $h .= qq{          <div class="stand-kop">\n};
  $h .= qq{            <span class="section-label">Stand van zaken</span>\n};
  $h .= qq{            <span class="status-pil status-$status">$label</span>\n};
  $h .= qq{          </div>\n};
  $h .= qq{          <p class="stand-tekst">} . r($k->{stand}) . qq{</p>\n};
  $h .= qq{          <div class="stand-duo">\n};
  $h .= qq{            <div>\n              <span class="stand-sub">Wat vandaag al kan</span>\n              <ul class="stand-lijst stand-ja">\n};
  $h .= qq{                <li>} . r($_) . qq{</li>\n} for @{ $k->{vandaag} };
  $h .= qq{              </ul>\n            </div>\n};
  $h .= qq{            <div>\n              <span class="stand-sub">Wat nog niet kan</span>\n              <ul class="stand-lijst stand-nee">\n};
  $h .= qq{                <li>} . r($_) . qq{</li>\n} for @{ $k->{nog_niet} };
  $h .= qq{              </ul>\n            </div>\n};
  $h .= qq{          </div>\n};
  $h .= qq{          <p class="stand-voet">} . r($k->{stand_voet}) . qq{</p>\n};
  $h .= qq{        </div>\n      </div>\n    </section>\n\n};

  # ── Vragen ─────────────────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="vragen">\n};
  $h .= qq{      <div class="section-glow" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <div class="section-header text-center reveal">\n};
  $h .= qq{          <span class="section-label">Vragen die we krijgen</span>\n};
  $h .= qq{          <h2 class="section-title">Kort en eerlijk.</h2>\n};
  $h .= qq{        </div>\n        <div class="vraag-lijst">\n};
  for my $v (@{ $k->{vragen} }) {
    $h .= qq{          <div class="vraag reveal">\n};
    $h .= qq{            <h3 class="vraag-kop">} . r($v->{vraag}) . qq{</h3>\n};
    $h .= qq{            <p class="vraag-antwoord">} . r($v->{antwoord}) . qq{</p>\n};
    $h .= qq{          </div>\n};
  }
  $h .= qq{        </div>\n      </div>\n    </section>\n\n};

  $h .= qq{    <section class="cta-band" data-gids="start">\n};
  $h .= qq{      <div class="cta-band-glow" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <h2 class="cta-band-title reveal">} . r($k->{cta}) . qq{</h2>\n};
  $h .= qq{        <p class="cta-band-sub reveal reveal-delay-1">Vertel ons in welk pakket je werkt. We zeggen eerlijk of het vandaag kan, of wanneer wel.</p>\n};
  $h .= qq{        <a href="../meeting.html" class="btn btn-lg reveal reveal-delay-2">Plan een demo <span class="btn-arrow" aria-hidden="true">&#8594;</span></a>\n};
  $h .= qq{      </div>\n    </section>\n};

  return $h;
}

my $n = 0;
for my $k (@$DATA) {
  my $pad = "koppelingen/$k->{slug}.html";
  open my $fh, '<:raw', $pad or die "$pad: $!\n";
  my $html = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my $main = blok($k);
  $html =~ s{(<main id="main">).*?(\n  </main>)}{$1\n$main$2}s
    or die "$pad: geen <main> gevonden\n";

  open my $o, '>:raw', $pad or die "$pad: $!";
  print $o encode_utf8($html);
  close $o;
  printf "  %-48s geschreven\n", $pad;
  $n++;
}
print "\n$n koppelingspagina's geschreven.\n";
