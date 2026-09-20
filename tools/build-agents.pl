#!/usr/bin/perl
# ============================================================================
# build-agents.pl — schrijft de tien agentpagina's uit één sjabloon
# ----------------------------------------------------------------------------
# Tien pagina's met dezelfde opbouw. Met de hand geschreven lopen die binnen
# een maand uit elkaar: de ene krijgt een extra blok, de andere houdt een oude
# formulering. Daarom staat de opbouw hier en staat de inhoud in
# tools/agents-data.pl.
#
# Wil je de tekst van een agent aanpassen, doe dat in tools/agents-data.pl en
# draai dit script opnieuw. Bewerk agents/*.html niet met de hand: de <main>
# daarvan wordt hier overschreven. De kop en de voet blijven ongemoeid, die
# horen bij tools/sync-shell.pl.
#
# Gebruik
#   perl tools/build-agents.pl
# ============================================================================
use strict;
use utf8;   # tekens in dit bestand zijn tekens, geen losse bytes
use warnings;
use Encode qw(decode_utf8 encode_utf8);

my $AGENTS = do './tools/agents-data.pl';
die "tools/agents-data.pl: $@\n" if $@;
die "tools/agents-data.pl gaf niets terug\n" unless ref $AGENTS eq 'ARRAY';

sub e {                       # tekst veilig in HTML
  my ($t) = @_;
  return '' unless defined $t;
  $t =~ s/&/&amp;/g; $t =~ s/</&lt;/g; $t =~ s/>/&gt;/g;
  return $t;
}

# Sommige teksten mogen wel opmaak bevatten. Daar staat <em>, <strong> of een
# <a> in, en die laten we met rust.
sub r { my ($t) = @_; return defined $t ? $t : '' }

my %NAAM = map { $_->{slug} => $_->{naam} } @$AGENTS;

sub blok_agent {
  my ($a) = @_;
  my $slug = $a->{slug};
  my $nr   = $a->{nr};

  my $h = '';

  # ── Kop ────────────────────────────────────────────────────────────────
  $h .= qq{    <section class="paghero" data-gids="hero">\n};
  $h .= qq{      <div class="paghero-bg" aria-hidden="true"></div>\n};
  $h .= qq{      <div class="container">\n};
  $h .= qq{        <nav class="kruimels" aria-label="Kruimelpad">\n};
  $h .= qq{          <a href="../index.html">Home</a>\n};
  $h .= qq{          <span aria-hidden="true">\x{00B7}</span>\n};
  $h .= qq{          <a href="index.html">Agents</a>\n};
  $h .= qq{          <span aria-hidden="true">\x{00B7}</span>\n};
  $h .= qq{          <span aria-current="page">} . e($a->{naam}) . qq{</span>\n};
  $h .= qq{        </nav>\n};
  $h .= qq{        <span class="section-label">Agent $nr van tien</span>\n};
  $h .= qq{        <h1 class="paghero-titel">} . r($a->{h1}) . qq{</h1>\n};
  $h .= qq{        <p class="paghero-lede">} . r($a->{lede}) . qq{</p>\n};
  $h .= qq{        <div class="paghero-acties">\n};
  $h .= qq{          <a href="../meeting.html" class="btn btn-lg">Plan een demo <span class="btn-arrow" aria-hidden="true">&#8594;</span></a>\n};
  $h .= qq{          <a href="../systeem.html" class="btn btn-ghost btn-lg">Zo zit het systeem in elkaar</a>\n};
  $h .= qq{        </div>\n};
  $h .= qq{      </div>\n};
  $h .= qq{    </section>\n\n};

  # ── Het probleem ───────────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="probleem">\n      <div class="container">\n};
  $h .= qq{        <div class="section-header reveal">\n};
  $h .= qq{          <span class="section-label">Zonder dit</span>\n};
  $h .= qq{          <h2 class="section-title">} . r($a->{probleem}{titel}) . qq{</h2>\n};
  $h .= qq{        </div>\n};
  $h .= qq{        <div class="prob-inhoud">\n};
  $h .= qq{          <div class="prob-tekst reveal">\n};
  $h .= qq{            <p>$_</p>\n} for @{ $a->{probleem}{tekst} };
  $h .= qq{          </div>\n};
  $h .= qq{          <ul class="prob-gevolgen reveal">\n};
  $h .= qq{            <li>} . r($_) . qq{</li>\n} for @{ $a->{probleem}{gevolgen} };
  $h .= qq{          </ul>\n};
  $h .= qq{        </div>\n};
  $h .= qq{      </div>\n    </section>\n\n};

  # ── De werkstroom ──────────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="werkstroom" id="werkstroom">\n};
  $h .= qq{      <div class="section-glow" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <div class="section-header text-center reveal">\n};
  $h .= qq{          <span class="section-label">De werkstroom</span>\n};
  $h .= qq{          <h2 class="section-title">Wat het systeem doet.</h2>\n};
  $h .= qq{          <p class="section-sub">} . r($a->{werkstroom_sub}) . qq{</p>\n};
  $h .= qq{        </div>\n};
  $h .= qq{        <ol class="ws-lijst">\n};
  my $i = 0;
  for my $s (@{ $a->{stappen} }) {
    $i++;
    my $vert = $i > 3 ? ' reveal-delay-1' : '';
    $h .= qq{          <li class="ws-stap reveal$vert">\n};
    $h .= sprintf(qq{            <span class="ws-nr">%02d</span>\n}, $i);
    $h .= qq{            <div>\n};
    $h .= qq{              <h3 class="ws-kop">} . r($s->{kop}) . qq{</h3>\n};
    $h .= qq{              <p class="ws-tekst">} . r($s->{tekst}) . qq{</p>\n};
    $h .= qq{            </div>\n          </li>\n};
  }
  $h .= qq{        </ol>\n      </div>\n    </section>\n\n};

  # ── Zo klinkt het ──────────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="gesprek">\n      <div class="container">\n};
  $h .= qq{        <div class="section-header text-center reveal">\n};
  $h .= qq{          <span class="section-label">Zo klinkt het</span>\n};
  $h .= qq{          <h2 class="section-title">Een gesprek dat hier uitkomt.</h2>\n};
  $h .= qq{          <p class="section-sub">Een voorbeeld, geen opname van een klant. De toon zet je zelf, dit is de onze.</p>\n};
  $h .= qq{        </div>\n};
  $h .= qq{        <div class="gesprek-kaart reveal">\n};
  $h .= qq{          <div class="gesprek-balk"><span>} . e($a->{gesprek}{kanaal}) . qq{</span><span class="gesprek-merk">Voorbeeld</span></div>\n};
  $h .= qq{          <div class="gesprek-body">\n};
  for my $regel (@{ $a->{gesprek}{regels} }) {
    my ($wie, $tekst) = @$regel;
    my $klasse = $wie eq 'Helvaro' ? 'cg-agent' : 'cg-klant';
    $h .= qq{            <div class="cg-regel $klasse"><span class="cg-wie">} . e($wie) . qq{</span>} . r($tekst) . qq{</div>\n};
  }
  $h .= qq{            <div class="cg-uitkomst">\n};
  $h .= qq{              <span class="cg-uitkomst-label">} . e($a->{gesprek}{uitkomst}[0]) . qq{</span>\n};
  $h .= qq{              <span class="cg-uitkomst-waarde">} . e($a->{gesprek}{uitkomst}[1]) . qq{</span>\n};
  $h .= qq{            </div>\n};
  $h .= qq{          </div>\n        </div>\n};
  $h .= qq{      </div>\n    </section>\n\n};

  # ── Wat het oplevert ───────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="opbrengst">\n};
  $h .= qq{      <div class="section-glow" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <div class="section-header text-center reveal">\n};
  $h .= qq{          <span class="section-label">Wat het oplevert</span>\n};
  $h .= qq{          <h2 class="section-title">} . r($a->{opbrengst_titel}) . qq{</h2>\n};
  $h .= qq{        </div>\n};
  $h .= qq{        <div class="duo-grid">\n};
  my $j = 0;
  for my $o (@{ $a->{opbrengst} }) {
    $j++;
    my $vert = $j > 2 ? ' reveal-delay-1' : '';
    $h .= qq{          <div class="duo-kaart reveal$vert spot">\n};
    $h .= qq{            <h3 class="duo-titel">} . r($o->{titel}) . qq{</h3>\n};
    $h .= qq{            <p class="duo-desc">} . r($o->{tekst}) . qq{</p>\n};
    $h .= qq{          </div>\n};
  }
  $h .= qq{        </div>\n      </div>\n    </section>\n\n};

  # ── In het systeem ─────────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="systeem">\n      <div class="container">\n};
  $h .= qq{        <div class="section-header reveal">\n};
  $h .= qq{          <span class="section-label">In het systeem</span>\n};
  $h .= qq{          <h2 class="section-title">Geen los hulpje.</h2>\n};
  $h .= qq{          <p class="section-sub">} . r($a->{systeem}{tekst}) . qq{</p>\n};
  $h .= qq{        </div>\n};
  $h .= qq{        <div class="sys-duo">\n};
  $h .= qq{          <div class="sys-blok reveal">\n};
  $h .= qq{            <span class="sys-kop">Welke lagen dit raakt</span>\n};
  $h .= qq{            <ul class="sys-lijst">\n};
  for my $l (@{ $a->{systeem}{lagen} }) {
    my ($anker, $naam, $wat) = @$l;
    $h .= qq{              <li><a href="../systeem.html#$anker">} . e($naam) . qq{</a><span>} . r($wat) . qq{</span></li>\n};
  }
  $h .= qq{            </ul>\n          </div>\n};
  $h .= qq{          <div class="sys-blok reveal reveal-delay-1">\n};
  $h .= qq{            <span class="sys-kop">Werkt samen met</span>\n};
  $h .= qq{            <ul class="sys-lijst">\n};
  for my $s (@{ $a->{systeem}{buren} }) {
    my ($slug, $wat) = @$s;
    my $naam = $NAAM{$slug} or die "onbekende agent: $slug\n";
    $h .= qq{              <li><a href="$slug.html">} . e($naam) . qq{</a><span>} . r($wat) . qq{</span></li>\n};
  }
  $h .= qq{            </ul>\n          </div>\n};
  $h .= qq{        </div>\n      </div>\n    </section>\n\n};

  # ── Grenzen ────────────────────────────────────────────────────────────
  $h .= qq{    <section class="section" data-gids="grenzen">\n};
  $h .= qq{      <div class="section-glow" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <div class="grens-kaart reveal">\n};
  $h .= qq{          <span class="section-label">Grenzen</span>\n};
  $h .= qq{          <h2 class="grens-titel">Wat deze agent niet doet.</h2>\n};
  $h .= qq{          <ul class="grens-lijst">\n};
  $h .= qq{            <li>} . r($_) . qq{</li>\n} for @{ $a->{grenzen} };
  $h .= qq{          </ul>\n        </div>\n};
  $h .= qq{      </div>\n    </section>\n\n};

  # ── Afsluiter ──────────────────────────────────────────────────────────
  $h .= qq{    <section class="cta-band" data-gids="start">\n};
  $h .= qq{      <div class="cta-band-glow" aria-hidden="true"></div>\n      <div class="container">\n};
  $h .= qq{        <h2 class="cta-band-title reveal">} . r($a->{cta}) . qq{</h2>\n};
  $h .= qq{        <p class="cta-band-sub reveal reveal-delay-1">Twintig minuten op je eigen cijfers. We laten zien wat deze werkstroom bij jou zou doen, of waarom je beter met een andere kunt beginnen.</p>\n};
  $h .= qq{        <a href="../meeting.html" class="btn btn-lg reveal reveal-delay-2">Plan een demo <span class="btn-arrow" aria-hidden="true">&#8594;</span></a>\n};
  $h .= qq{      </div>\n    </section>\n};

  return $h;
}

my $n = 0;
for my $a (@$AGENTS) {
  my $pad = "agents/$a->{slug}.html";
  open my $fh, '<:raw', $pad or die "$pad: $! (draai eerst tools/nieuwe-paginas.pl)\n";
  my $html = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my $main = blok_agent($a);
  $html =~ s{(<main id="main">).*?(\n  </main>)}{$1\n$main$2}s
    or die "$pad: geen <main> gevonden\n";

  open my $o, '>:raw', $pad or die "$pad: $!";
  print $o encode_utf8($html);
  close $o;
  printf "  %-48s geschreven\n", $pad;
  $n++;
}
print "\n$n agentpagina's geschreven.\n";
