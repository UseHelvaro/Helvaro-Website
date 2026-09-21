#!/usr/bin/perl
# ============================================================================
# nieuwe-paginas.pl — schrijft het geraamte van een nieuwe pagina
# ----------------------------------------------------------------------------
# Eenmalig bedoeld. Het zet de kop (titel, beschrijving, canonical, hreflang),
# de merktekens voor tools/sync-shell.pl, een lege <main> en de scripts
# onderaan. De inhoud van <main> schrijf je daarna gewoon met de hand.
#
# Een bestaande pagina wordt NOOIT overschreven. Wil je een kop opnieuw laten
# zetten, verwijder het bestand dan eerst zelf.
#
# Gebruik
#   perl tools/nieuwe-paginas.pl
# ============================================================================
use strict;
use utf8;   # tekens in dit bestand zijn tekens, geen losse bytes
use warnings;
use Encode qw(encode_utf8);
use File::Path qw(make_path);
use File::Basename qw(dirname);

my $BASE = 'https://helvaro.pro';
my @LANGS = qw(nl fr en de es);

# pad, titel, beschrijving
my @PAGINAS = (
  ['systeem.html',
   'Het Helvaro-systeem: van klantcontact naar werkplaatsafspraak',
   'Vijf lagen: opvangen, begrijpen, handelen, koppelen en meten. Zo wordt binnenkomend klantcontact een afspraak in je werkplaatsplanning.'],

  ['automotive.html',
   'AI voor autobedrijven: meer werkplaatsafspraken uit je klantcontact',
   'Voor onafhankelijke garages en universele werkplaatsen. Gemiste gesprekken, APK, offertes en no-shows worden werkstromen in plaats van losse ergernissen.'],

  ['roi.html',
   'Omzetcalculator: wat lekt er weg in je werkplaats?',
   'Vul vier cijfers in over je eigen werkplaats en zie een schatting van de omzet die blijft liggen door gemiste gesprekken. Geen e-mailadres nodig.'],

  ['cases.html',
   'Cijfers en pilot: wat we meten en wat we nog niet bewijzen',
   'We hebben nog geen gemeten resultaat in een werkplaats, en verzinnen er ook geen. Dit is wat we meten en hoe de pilot eruitziet.'],

  ['agents/index.html',
   'De tien agents van het Helvaro-systeem',
   'APK, werkplaatsplanning, gemiste gesprekken, offertes, no-shows en meer. Tien werkstromen binnen hetzelfde systeem, met hetzelfde geheugen.'],

  ['agents/apk-herinnering-agent.html',
   'APK-herinnering-agent: van vervaldatum naar geboekte keuring',
   'Zes weken voor de APK verloopt een bericht met een concrete datum erbij. Vragen worden beantwoord, de afspraak wordt vastgezet.'],

  ['agents/werkplaats-inplan-agent.html',
   'Werkplaats-inplan-agent: afspraken die in je planning passen',
   'Een keuring is geen distributieriem. De agent weet hoelang een klus duurt en boekt het tijdslot dat erbij hoort.'],

  ['agents/gemiste-gesprekken-agent.html',
   'Gemiste-gesprekken-agent: elke onbeantwoorde oproep krijgt antwoord',
   'Wie niet doorkomt krijgt binnen een minuut een bericht, met de vraag waar het over gaat en een voorstel voor een tijdslot.'],

  ['agents/offerte-opvolg-agent.html',
   'Offerte-opvolg-agent: een prijs die de deur uitgaat, komt ook terug',
   'Drie contactmomenten na een prijsopgave, in jouw toon. Een duidelijk nee is ook een resultaat, want dan stopt het naijlen.'],

  ['agents/no-show-agent.html',
   'No-show-agent: minder lege bruggen, minder loze uren',
   'Bevestigen, herinneren en het vrijgekomen tijdslot meteen aanbieden aan iemand die wacht. Een lege brug kost evenveel als een volle.'],

  ['agents/onderdelen-navraag-agent.html',
   'Onderdelen-navraag-agent: de klant weet waar hij aan toe is',
   'Levertijd, prijs en beschikbaarheid van onderdelen worden nagevraagd en teruggekoppeld, zodat je balie niet drie keer hoeft te bellen.'],

  ['agents/leenauto-agent.html',
   'Leenauto-agent: beschikbaarheid en reservering in één gesprek',
   'Is er een leenauto vrij, wat kost het en wat zijn de voorwaarden. De vraag die elke afspraak vertraagt, meteen beantwoord.'],

  ['agents/schade-intake-agent.html',
   'Schade-intake-agent: gegevens compleet voor de auto binnenrijdt',
   "Foto's, kenteken, verzekeraar en toedracht worden opgehaald voor de klant langskomt, zodat de eerste afspraak meteen klopt."],

  ['agents/winterbanden-oproep-agent.html',
   'Bandenwissel-agent: twee seizoenen, één campagne',
   'Twee keer per jaar een volle week werk, mits iemand op tijd begint. De agent benadert je hele bandenbestand en plant de wissels in.'],

  ['agents/onderhoudsbeurt-herinnering-agent.html',
   'Onderhoudsbeurt-agent: op kilometers of op datum',
   'De klant die anders nog een half jaar doorrijdt, boekt nu. Herinneringen op basis van je eigen intervallen, niet op een vast schema.'],

  ['controle.html',
   'Controle en privacy: wat een agent mag, en waar je data staat',
   'Elk gesprek leesbaar, goedkeuring per actietype, een noodstop per agent en verwerking binnen de EU. De afspraken die vastliggen voor we starten.'],

  ['faro.html',
   'Faro: het gezicht van het Helvaro-systeem',
   'Faro is niet het product maar de laag waarin je meeleest, goedkeurt en in gewone taal vraagt wat er gebeurd is.'],

  ['koppelingen/index.html',
   'Koppelingen: waar Helvaro in je bestaande software past',
   'Een afspraak die alleen bij ons staat is geen afspraak. Dit is de eerlijke stand van zaken per koppeling: live, in ontwikkeling of gepland.'],

  ['koppelingen/automaat-go.html',
   'Helvaro en AutomaaT GO',
   'Afspraken en klantgegevens naar het pakket waar veel onafhankelijke garages in werken. Stand van zaken, opzet en wat er nog niet is.'],

  ['koppelingen/autoflex.html',
   'Helvaro en Autoflex',
   'Werkorders en werkplaatsplanning, zodat een geboekt tijdslot ook echt een werkorder wordt. Stand van zaken en de beoogde opzet.'],

  ['koppelingen/wincar.html',
   'Helvaro en WinCar',
   'Klanthistorie en voertuigdossier als context onder elk gesprek. Stand van zaken en de beoogde opzet.'],

  ['koppelingen/rdw-kenteken.html',
   'Helvaro en het RDW-kentekenregister',
   'Voertuiggegevens en APK-vervaldatum op basis van het kenteken dat de klant noemt. Stand van zaken en wat we wel en niet opslaan.'],

  ['sectoren/keuken.html',
   'Keukenzaken: van aanvraag naar geboekte opmeting',
   'Helvaro kwalificeert keukenaanvragen op budget, timing en type project, plant een opmeting of showroombezoek in en volgt de offerte nadien op.'],
);

sub op { my ($diep) = @_; return $diep == 0 ? '' : '../' x $diep }

my $gemaakt = 0;
for my $rij (@PAGINAS) {
  my ($pad, $titel, $desc) = @$rij;

  if (-f $pad) { printf "  %-48s bestaat al\n", $pad; next; }

  my $diep = ($pad =~ tr{/}{});
  my $o    = op($diep);

  # index.html verdwijnt uit de URL, net als bij de hoofdmap.
  (my $url = $pad) =~ s{(^|/)index\.html$}{$1};

  my $volle_titel = "$titel \x{00B7} Helvaro";
  my $veilig = $desc; $veilig =~ s/"/&quot;/g;

  my $alt = '';
  for my $l (@LANGS) {
    my $href = $l eq 'nl' ? "$BASE/$url" : "$BASE/$l/$url";
    $alt .= qq{\n  <link rel="alternate" hreflang="$l" href="$href">};
  }
  $alt .= qq{\n  <link rel="alternate" hreflang="x-default" href="$BASE/$url">};

  my $html = <<"HTML";
<!DOCTYPE html>
<html lang="nl">
<head>
  <script>document.documentElement.classList.add('js');</script>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>$volle_titel</title>
  <meta name="description" content="$veilig">
  <meta property="og:title" content="$volle_titel">
  <meta property="og:description" content="$veilig">
  <meta property="og:image" content="$BASE/assets/og-card.png">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta property="og:locale" content="nl_BE">
  <meta property="og:site_name" content="Helvaro">
  <meta property="og:url" content="$BASE/$url">
  <meta property="og:type" content="website">
  <meta name="twitter:card" content="summary_large_image">
  <link rel="canonical" href="$BASE/$url">$alt
  <link rel="icon" href="${o}assets/favicon.ico" sizes="any">
  <link rel="icon" type="image/png" sizes="32x32" href="${o}assets/favicon-32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="${o}assets/favicon-16.png">
  <link rel="apple-touch-icon" href="${o}assets/apple-touch-icon.png">
  <meta name="theme-color" content="#121212">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght\@12..96,500..700&family=Instrument+Serif:ital\@0;1&family=Inter:wght\@400;500;600&display=swap" rel="stylesheet">
  <script>/* Thema vooraf zetten zodat de pagina niet even in de verkeerde kleur flitst */
    (function(){try{var t=localStorage.getItem('helvaro_theme');document.documentElement.setAttribute('data-theme',t==='light'?'light':'dark');}catch(e){document.documentElement.setAttribute('data-theme','dark');}})();
  </script>
  <link rel="stylesheet" href="${o}css/style.css?v=94">
</head>
<body>
  <a class="skip-link" href="#main">Naar de inhoud</a>

<!-- SHELL:NAV -->
<!-- /SHELL:NAV -->

  <main id="main">
  </main>

<!-- SHELL:FOOTER -->
<!-- /SHELL:FOOTER -->

  <script src="${o}js/main.js?v=93"></script>
  <script src="${o}js/i18n.js?v=93"></script>

  <aside class="faro-gids" id="faroGids" data-plek="rechtsonder" hidden>
    <div class="faro-gids-ballon" id="faroGidsBallon" aria-live="polite">
      <p class="faro-gids-tekst" id="faroGidsTekst"></p>
      <button type="button" class="faro-gids-sluit" id="faroGidsSluit"
              aria-label="Faro verbergen">&times;</button>
    </div>
    <img class="faro-gids-img" id="faroGidsImg" src="${o}assets/faro/falcon-idle.webp"
         alt="" aria-hidden="true" width="416" height="400" decoding="async">
  </aside>
</body>
</html>
HTML

  make_path(dirname($pad)) if $diep;
  open my $fh, '>:raw', $pad or die "$pad: $!";
  print $fh encode_utf8($html);
  close $fh;
  printf "  %-48s geschreven\n", $pad;
  $gemaakt++;
}

print "\n$gemaakt geraamtes geschreven.\n";
