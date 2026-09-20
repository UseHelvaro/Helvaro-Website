#!/usr/bin/perl
# ============================================================================
# build-langs.pl — maakt /fr/, /en/, /de/ en /es/ als echte pagina's
# ----------------------------------------------------------------------------
# Waarom dit bestaat
#   De site vertaalde alleen in de browser. Alle talen deelden één URL, dus
#   Google zag enkel de Nederlandse versie. Voor een Belgisch bedrijf is dat
#   duur: half het land zoekt in het Frans en vond niets.
#
#   Dit script neemt de Nederlandse pagina's als bron, past dezelfde
#   vertalingen toe die de browser gebruikt, en schrijft per taal een echte
#   HTML-pagina weg. Eén bron, vier kopieën, geen handwerk.
#
# Gebruik
#   perl tools/build-langs.pl
#   Draai het na elke inhoudelijke wijziging aan een Nederlandse pagina.
#
# Belangrijk
#   De mappen /fr /en /de /es worden volledig overschreven. Bewerk daar niets
#   met de hand, je werk is de volgende keer weg. Bewerk altijd de bron.
# ============================================================================
use strict;
use utf8;   # tekens in dit bestand zijn tekens, geen losse bytes
use warnings;
use Encode qw(decode_utf8 encode_utf8);
use File::Path qw(make_path remove_tree);
use File::Basename qw(dirname);

my @LANGS = qw(fr en de es);

# Eigennamen, merken en codes. Die blijven in elke taal hetzelfde en horen
# dus niet in de lijst met ontbrekende vertalingen.
our $NEGEER = qr/^(?:Helvaro|Faro|Login|Home|Contact|FAQ|WhatsApp|Automotive|
                    HubSpot|Pipedrive|Teamleader|LinkedIn|Starter|Growth|Scale|
                    GDPR|Leads|Pipeline|HELVARO|CRM|online|
                    # Talen staan in hun eigen taal in de kiezer, dat is de bedoeling.
                    Nederlands|Deutsch|English|Fran\x{00e7}ais|Espa\x{00f1}ol|
                    # Namen, merken en vaste termen.
                    Mathis\s.*|Driss\s.*|Wout\s.*|Sindi\sSaid|Stefan\sV\.|
                    Teljo\sCrisrosio\sKodia|Passat.*|
                    Co-Founder\s.*|Limited\sUse|E-Mail:?|Google\sAgenda|
                    app\.helvaro\.pro|hello\@helvaro\.pro|\x{00a9}\s*\d{4}\sHelvaro)$/x;

my %LOCALE = (nl => 'nl_BE', fr => 'fr_BE', en => 'en_GB', de => 'de_DE', es => 'es_ES');
my $BASE = 'https://helvaro.pro';

# Bronpagina's, relatief aan de hoofdmap.
my @PAGES = qw(
  index.html
  systeem.html
  automotive.html
  agents/index.html
  roi.html
  cases.html
  koppelingen/index.html
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
  koppelingen/automaat-go.html
  koppelingen/autoflex.html
  koppelingen/wincar.html
  koppelingen/rdw-kenteken.html
  waarom.html
  meeting.html
  sectoren/vastgoed.html
  sectoren/bouw.html
  contact.html
  aanmelden.html
  privacybeleid.html
);

# ── 1. Woordenboeken uit de taalbestanden halen ─────────────────────────────
# De bestanden zijn JavaScript, geen JSON, dus we vissen de "sleutel": "waarde"
# paren er met een reguliere expressie uit. Dat werkt omdat ze allemaal in die
# ene vorm staan, zowel in het gegenereerde blok als in de Object.assign-blokken.
sub laad_dict {
  my ($lang) = @_;
  my $pad = "js/lang/$lang.js";
  open my $fh, '<:raw', $pad or die "$pad: $!";
  my $src = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my %d;
  while ($src =~ /"((?:[^"\\]|\\.)*)"\s*:\s*"((?:[^"\\]|\\.)*)"/g) {
    my ($k, $v) = ($1, $2);
    for ($k, $v) { s/\\"/"/g; s/\\\\/\\/g; s/\\n/\n/g; }
    $d{$k} = $v;
  }
  return \%d;
}

# ── 2. Blokken met opmaak en titels uit i18n.js halen ───────────────────────
sub laad_i18n_blokken {
  open my $fh, '<:raw', 'js/i18n.js' or die "js/i18n.js: $!";
  my $src = decode_utf8(do { local $/; <$fh> });
  close $fh;
  $src =~ s/\\u([0-9a-fA-F]{4})/chr(hex($1))/ge;   # · enzovoort

  my (%hero, %blok, %titel);

  # HERO = { nl: '...', fr: '...', ... }
  if ($src =~ /var\s+HERO\s*=\s*\{(.*?)\n\s*\};/s) {
    my $body = $1;
    while ($body =~ /(\w{2})\s*:\s*'((?:[^'\\]|\\.)*)'/g) {
      my ($l, $v) = ($1, $2); $v =~ s/\\'/'/g; $hero{$l} = $v;
    }
  }

  # HTML_BLOKKEN = { naam: { nl: "...", fr: "..." }, ... }
  if ($src =~ /var\s+HTML_BLOKKEN\s*=\s*\{(.*)\n\s*\};/s) {
    my $body = $1;
    while ($body =~ /(\w+)\s*:\s*\{(.*?)\n\s{4}\}/gs) {
      my ($naam, $inner) = ($1, $2);
      # Sommige blokken staan tussen dubbele aanhalingstekens, andere tussen
      # enkele. heroSub was enkel, en werd daardoor stil overgeslagen.
      while ($inner =~ /(\w{2})\s*:\s*(?:"((?:[^"\\]|\\.)*)"|'((?:[^'\\]|\\.)*)')/g) {
        my $l = $1;
        my $v = defined $2 ? $2 : $3;
        $v =~ s/\\"/"/g; $v =~ s/\\'/'/g;
        $blok{$naam}{$l} = $v;
      }
    }
  }

  # TITLES = { 'NL titel': { fr: '...', ... }, ... }
  if ($src =~ /var\s+TITLES\s*=\s*\{(.*)\n\s*\};/s) {
    my $body = $1;
    while ($body =~ /'((?:[^'\\]|\\.)*)'\s*:\s*\{(.*?)\n\s{4}\}/gs) {
      my ($nl, $inner) = ($1, $2);
      while ($inner =~ /(\w{2})\s*:\s*'((?:[^'\\]|\\.)*)'/g) {
        my ($l, $v) = ($1, $2); $v =~ s/\\'/'/g; $titel{$nl}{$l} = $v;
      }
    }
  }
  return (\%hero, \%blok, \%titel);
}

# ── 3. Entiteiten ───────────────────────────────────────────────────────────
# De sleutels in het woordenboek staan zoals de browser de tekst ziet, dus
# met echte tekens. In de HTML staan entiteiten. Heen en terug vertalen.
my %ENT = (
  'amp' => '&', 'lt' => '<', 'gt' => '>', 'quot' => '"', 'nbsp' => ' ',
  'middot' => "\x{00b7}", 'euro' => "\x{20ac}", 'copy' => "\x{00a9}",
  'hellip' => "\x{2026}", 'rsquo' => "\x{2019}", 'lsquo' => "\x{2018}",
  'ldquo' => "\x{201c}", 'rdquo' => "\x{201d}", 'laquo' => "\x{00ab}",
  'raquo' => "\x{00bb}", 'times' => "\x{00d7}", 'rarr' => "\x{2192}",
  'larr' => "\x{2190}", 'sup2' => "\x{00b2}", 'deg' => "\x{00b0}",
  'eacute' => "\x{00e9}", 'egrave' => "\x{00e8}",
  'ccedil' => "\x{00e7}", 'ntilde' => "\x{00f1}", 'uuml' => "\x{00fc}",
  'auml' => "\x{00e4}", 'ouml' => "\x{00f6}", 'szlig' => "\x{00df}",
  'iacute' => "\x{00ed}", 'oacute' => "\x{00f3}", 'aacute' => "\x{00e1}",
  'uacute' => "\x{00fa}", 'rsaquo' => "\x{203a}", 'lsaquo' => "\x{2039}",
);
sub decode_ents {
  my ($s) = @_;
  $s =~ s/&#(\d+);/chr($1)/ge;
  $s =~ s/&#x([0-9a-fA-F]+);/chr(hex($1))/ge;
  $s =~ s/&(\w+);/exists $ENT{$1} ? $ENT{$1} : "&$1;"/ge;
  return $s;
}
# Alleen wat kapot zou gaan in HTML terug coderen. De rest mag UTF-8 blijven.
sub encode_ents {
  my ($s) = @_;
  $s =~ s/&/&amp;/g;
  $s =~ s/</&lt;/g;
  $s =~ s/>/&gt;/g;
  return $s;
}

# ── 4. Tekstknopen in de HTML vervangen ─────────────────────────────────────
# Simpele toestandsmachine: alles tussen < en > is opmaak, de rest is tekst.
# Inhoud van <script>, <style> en commentaar blijft ongemoeid.
sub vertaal_tekst {
  my ($html, $dict, $mist) = @_;
  my $uit = '';
  my $n = 0;

  while (length $html) {
    if ($html =~ /\A(<!--.*?-->)/s) { $uit .= $1; $html = substr($html, length $1); next; }
    if ($html =~ /\A(<(script|style)\b[^>]*>.*?<\/\2>)/si) {
      $uit .= $1; $html = substr($html, length $1); next;
    }
    if ($html =~ /\A(<[^>]*>)/s) { $uit .= $1; $html = substr($html, length $1); next; }
    if ($html =~ /\A([^<]+)/s) {
      my $stuk = $1;
      $html = substr($html, length $stuk);
      my ($voor) = $stuk =~ /\A(\s*)/;
      my ($na)   = $stuk =~ /(\s*)\z/;
      my $kern = $stuk;
      $kern =~ s/\A\s+//; $kern =~ s/\s+\z//;
      if (length $kern) {
        my $sleutel = decode_ents($kern);
        $sleutel =~ s/\s+/ /g;
        if (exists $dict->{$sleutel}) {
          $uit .= $voor . encode_ents($dict->{$sleutel}) . $na;
          $n++;
          next;
        }
        # Niet gevonden. Eigennamen, cijfers en losse tekens tellen niet mee,
        # de rest is echt werk dat nog gedaan moet worden.
        if ($mist && $sleutel =~ /[A-Za-z]{4}/ && $sleutel !~ $::NEGEER) {
          $mist->{$sleutel} = 1;
        }
      }
      $uit .= $stuk;
      next;
    }
    $uit .= $html; last;
  }
  return ($uit, $n);
}

# ── 5. Bouwen ───────────────────────────────────────────────────────────────
my ($HERO, $BLOK, $TITEL) = laad_i18n_blokken();
my %DICT = map { $_ => laad_dict($_) } @LANGS;

# hreflang-blok voor een pagina, gelijk voor alle talen.
sub alternates {
  my ($pagina) = @_;
  my $p = $pagina eq 'index.html' ? '' : $pagina;
  my $out = qq{\n  <link rel="alternate" hreflang="nl" href="$BASE/$p">};
  $out .= qq{\n  <link rel="alternate" hreflang="$_" href="$BASE/$_/$p">} for @LANGS;
  $out .= qq{\n  <link rel="alternate" hreflang="x-default" href="$BASE/$p">};
  return $out;
}

# ── Taalkiezer ──────────────────────────────────────────────────────────────
# Absolute paden, zodat dezelfde opmaak klopt vanuit de hoofdmap, vanuit
# /fr/ en vanuit /fr/sectoren/. De kiezer navigeert nu echt: de taal zit in
# de URL, dus inhoud en canonical spreken elkaar nooit tegen.
my %TAALNAAM = (
  nl => ['Nederlands', 'NL'], fr => ['Fran&ccedil;ais', 'FR'],
  en => ['English', 'EN'],    de => ['Deutsch', 'DE'], es => ['Espa&ntilde;ol', 'ES'],
);
sub zet_taalkiezer {
  my ($html, $pagina, $huidig) = @_;
  my $p = $pagina eq 'index.html' ? '' : $pagina;

  my $items = '';
  for my $l ('nl', @LANGS) {
    my $href = $l eq 'nl' ? "/$p" : "/$l/$p";
    my ($naam, $code) = @{ $TAALNAAM{$l} };
    my $actief = $l eq $huidig ? ' active' : '';
    my $huidige_attr = $l eq $huidig ? ' aria-current="true"' : '';
    $items .= qq{\n            <a class="lang-opt$actief" role="menuitem" href="$href" hreflang="$l"$huidige_attr data-lang="$l">$naam <span class="lang-code">$code</span></a>};
  }
  $items .= "\n          ";

  # Zowel de vaste als de mobiele navigatie hebben er een.
  $html =~ s{(<div class="lang-menu" role="menu">).*?(</div>)}{$1$items$2}gs;
  $html =~ s{(<span class="lang-current">)[^<]*(</span>)}{$1$TAALNAAM{$huidig}[1]$2}g;
  return $html;
}

# ── FAQ-gegevens voor Google ────────────────────────────────────────────────
# De vragen en antwoorden staan al als tekst op de pagina. Die hier nog eens
# met de hand in JSON overtypen betekent twee plekken die uit elkaar gaan
# lopen. Dus lezen we ze uit de pagina zelf, ná het vertalen, waardoor elke
# taal vanzelf de juiste tekst krijgt.
sub json_tekst {
  my ($s) = @_;
  $s = decode_ents($s);
  $s =~ s/\s+/ /g;
  $s =~ s/^\s+|\s+$//g;
  $s =~ s/\\/\\\\/g;
  $s =~ s/"/\\"/g;
  return $s;
}
sub faq_schema {
  my ($html) = @_;
  my (@q, @a);
  while ($html =~ /<button class="faq-question"[^>]*>\s*(.*?)\s*<span class="faq-chevron"/gs) { push @q, $1 }
  while ($html =~ /<p class="faq-answer-inner">(.*?)<\/p>/gs)                                  { push @a, $1 }
  return '' unless @q && @q == @a;

  my @items;
  for my $i (0 .. $#q) {
    my $vraag    = json_tekst($q[$i]);
    my $antwoord = json_tekst($a[$i]);
    $antwoord =~ s/<[^>]*>//g;
    next unless length $vraag && length $antwoord;
    push @items, qq({"\@type":"Question","name":"$vraag","acceptedAnswer":{"\@type":"Answer","text":"$antwoord"}});
  }
  return '' unless @items;
  return qq(\n  <script type="application/ld+json">\n)
       . qq({"\@context":"https://schema.org","\@type":"FAQPage","mainEntity":[)
       . join(',', @items)
       . qq(]}\n  </script>);
}
sub zet_faq_schema {
  my ($html) = @_;
  $html =~ s{\n\s*<script type="application/ld\+json">\s*\{"\@context":"https://schema\.org","\@type":"FAQPage".*?</script>}{}gs;
  my $blok = faq_schema($html);
  $html =~ s{(\n</head>)}{$blok$1} if $blok;
  return $html;
}

for my $lang (@LANGS) { remove_tree($lang) if -d $lang; }

my %MIST = map { $_ => {} } @LANGS;
my $totaal = 0;
for my $pagina (@PAGES) {
  open my $fh, '<:raw', $pagina or die "$pagina: $!";
  my $bron = decode_utf8(do { local $/; <$fh> });
  close $fh;

  my $diep = ($pagina =~ tr{/}{});          # 0 in de hoofdmap, 1 in sectoren/
  my $p_url = $pagina eq 'index.html' ? '' : $pagina;

  # ── De Nederlandse bron krijgt hreflang en dezelfde navigerende taalkiezer.
  #    Zo gedragen alle vijf de talen zich identiek en staat de taal altijd
  #    in de URL.
  my $nl = $bron;
  $nl =~ s{\n\s*<link rel="alternate"[^>]*>}{}g;
  my $alt = alternates($pagina);
  $nl =~ s{(<link rel="canonical"[^>]*>)}{$1$alt};
  $nl = zet_taalkiezer($nl, $pagina, 'nl');
  $nl = zet_faq_schema($nl);
  if ($nl ne $bron) {
    open my $o, '>:raw', $pagina or die "$pagina: $!";
    print $o encode_utf8($nl);
    close $o;
    $bron = $nl;   # de vertalingen vertrekken van dezelfde bron
  }

  for my $lang (@LANGS) {
    my $h = $bron;

    # 5a. Blokken met opmaak, vóór de tekstvervanging, anders matcht de
    #     losse tekst binnenin niet meer.
    $h =~ s{(<([a-z0-9]+)\b[^>]*\bdata-i18n-html="(\w+)"[^>]*>)(.*?)(</\2>)}{
      my ($open, $tag, $naam, $inhoud, $dicht) = ($1, $2, $3, $4, $5);
      my $nieuw = $BLOK->{$naam}{$lang};
      $open . (defined $nieuw ? $nieuw : $inhoud) . $dicht;
    }gse;

    # 5b. De hero staat apart in i18n.js.
    if (my $hv = $HERO->{$lang}) {
      $h =~ s{(<h1 class="hero-title"[^>]*>)(.*?)(</h1>)}{$1$hv$3}s;
    }

    # 5c. Gewone tekstknopen.
    my ($vertaald, $n) = vertaal_tekst($h, $DICT{$lang});

    # Ontbrekende vertalingen opsporen op de schone Nederlandse bron, niet op
    # $h. In $h staan de blokken met opmaak al vertaald, en die zouden anders
    # als "niet gevonden" gemeld worden terwijl er niets aan de hand is.
    my $speur = $bron;
    $speur =~ s{<([a-z0-9]+)\b[^>]*\bdata-i18n-html="[^"]*"[^>]*>.*?</\1>}{}gs;
    $speur =~ s{<h1 class="hero-title"[^>]*>.*?</h1>}{}s;
    $speur =~ s{<title>.*?</title>}{}s;
    vertaal_tekst($speur, $DICT{$lang}, $MIST{$lang});
    $h = $vertaald;

    # 5d. Titel en omschrijving. De omschrijving staat in een attribuut en
    #     ontsnapt dus aan de tekstvervanging hierboven.
    if ($h =~ m{<title>(.*?)</title>}s) {
      my $nl_titel = decode_ents($1);
      # De oorspronkelijke pagina's staan in TITLES in i18n.js. Voor nieuwe
      # titels is dat een tweede plek om te vullen, en die loopt uit elkaar.
      # Staat een titel niet in TITLES, dan pakken we hem uit het gewone
      # woordenboek. Zo is er maar één plaats om te vertalen.
      my $t = $TITEL->{$nl_titel}{$lang} || $DICT{$lang}{$nl_titel};
      if ($t) {
        $h =~ s{<title>.*?</title>}{<title>$t</title>}s;
        $h =~ s{(<meta property="og:title" content=")[^"]*(")}{$1$t$2};
      }
    }
    if ($bron =~ m{<meta name="description" content="([^"]*)"}) {
      my $nl_desc = decode_ents($1);
      $nl_desc =~ s/\s+/ /g;
      if (my $d = $DICT{$lang}{$nl_desc}) {
        my $veilig = $d; $veilig =~ s/"/&quot;/g;
        $h =~ s{(<meta name="description" content=")[^"]*(")}{$1$veilig$2};
        $h =~ s{(<meta property="og:description" content=")[^"]*(")}{$1$veilig$2};
      }
    }

    # 5e. Taal, locale, canonical en alternates.
    $h =~ s{<html lang="nl">}{<html lang="$lang">};
    $h =~ s{(<meta property="og:locale" content=")[^"]*(")}{$1$LOCALE{$lang}$2};
    $h =~ s{(<link rel="canonical" href=")[^"]*(")}{$1$BASE/$lang/$p_url$2};
    $h =~ s{(<meta property="og:url" content=")[^"]*(")}{$1$BASE/$lang/$p_url$2};
    $h =~ s{\n\s*<link rel="alternate"[^>]*>}{}g;
    my $alt = alternates($pagina);
    $h =~ s{(<link rel="canonical"[^>]*>)}{$1$alt};

    # 5f. Paden. De taalmap zit één niveau dieper, dus alles wat relatief is
    #     krijgt er een ../ bij. Interne pagina's blijven binnen de taal.
    my $op = '../' x ($diep + 1);
    # srcset hoort in dit rijtje. Zonder deze stond in /fr/ nog
    # assets/photos/x.webp, wat daar een 404 is. Een <source> die mist valt
    # niet terug op de <img> ernaast, dus het beeld bleef gewoon leeg.
    for my $attr (qw(href src srcset)) {
      $h =~ s{(\b$attr=")(?!https?:|//|/|\#|mailto:|tel:)([^"]*)(")}{
        my ($a, $pad, $q) = ($1, $2, $3);
        if ($pad =~ m{^(?:\.\./)*(?:css/|js/|assets/)}) {
          $pad =~ s{^(?:\.\./)*}{$op};                 # gedeelde bestanden
        }
        $a . $pad . $q;
      }ge;
    }

    # 5g. De taalkiezer navigeert, hij schakelt niet meer in de browser.
    $h = zet_taalkiezer($h, $pagina, $lang);

    # 5h. De browservertaling mag hier niets meer doen.
    $h =~ s{<body}{<body data-vertaald="$lang"};

    $h = zet_faq_schema($h);

    my $doelpad = "$lang/$pagina";
    make_path(dirname($doelpad));
    open my $o, '>:raw', $doelpad or die "$doelpad: $!";
    print $o encode_utf8($h);
    close $o;
    $totaal++;
    printf "  %-34s %3d zinnen vertaald\n", $doelpad, $n;
  }
}
print "\n$totaal pagina's gebouwd.\n";

# ── 6. Wat nog geen vertaling heeft ─────────────────────────────────────────
# Zonder vertaling valt een zin terug op het Nederlands. Dat breekt niets,
# maar op een Franse pagina valt het meteen op. Daarom hier expliciet.
my $zonder = 0;
for my $lang (@LANGS) {
  my @m = sort keys %{ $MIST{$lang} };
  next unless @m;
  $zonder += scalar @m;
  printf "\n%s mist %d vertaling%s:\n", $lang, scalar @m, (@m == 1 ? '' : 'en');
  my $top = $#m;
  for my $z (@m[0 .. $top]) {
    printf "   %s\n", (length($z) > 72 ? substr($z, 0, 69) . '...' : $z);
  }
  print "   ...\n" if $#m > 9;
}
print $zonder
  ? "\nVul die aan in js/lang/*.js en draai opnieuw.\n"
  : "\nElke zin heeft in alle vier de talen een vertaling.\n";

# Met --dump komen de ontbrekende zinnen voluit in tools/mist-<taal>.txt te
# staan. Bij een grote uitbreiding is dat handiger dan een afgekapte lijst op
# het scherm: één bestand per taal, klaar om te vertalen.
if (grep { $_ eq '--dump' } @ARGV) {
  print "\n";
  for my $lang (@LANGS) {
    my @m = sort keys %{ $MIST{$lang} };
    my $pad = "tools/mist-$lang.txt";
    open my $uit, '>:raw', $pad or die "$pad: $!";
    print $uit encode_utf8(join("\n", @m) . "\n") if @m;
    close $uit;
    printf "%-22s %4d zinnen\n", $pad, scalar @m;
  }
}
