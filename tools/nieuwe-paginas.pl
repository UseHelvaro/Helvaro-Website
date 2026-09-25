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

  ['agents/nieuwe-aanvraag.html',
   'Nieuwe aanvraag: van vraag over een auto naar afspraak',
   'Een koper vraagt of een wagen er nog staat. Helvaro antwoordt met de gegevens uit je voorraad, beantwoordt de vragen erna en zet een moment vast.'],

  ['agents/proefrit.html',
   'Proefrit inplannen zonder heen en weer',
   'Eerst nakijken of de wagen vrij is, dan pas een moment noemen. Met bevestiging, herinnering en de wagen aan de afspraak.'],

  ['agents/voertuigadvies.html',
   'Voertuigadvies: van eisen naar drie wagens die er staan',
   'Een koper zoekt op budget, carrosserie en kilometers in plaats van op een model. Helvaro zoekt in je voorraad en legt het verschil uit.'],

  ['agents/inruil.html',
   'Inruil: de gegevens binnen voor de koper voorrijdt',
   'Merk, bouwjaar, kilometerstand, historiek en foto’s worden opgehaald. Het bedrag bepaalt je verkoper, niet het systeem.'],

  ['agents/financiering.html',
   'Financiering: het koopsignaal dat niet mag doodlopen',
   'Uitleggen waar een maandbedrag van afhangt, ophalen wat nodig is en op tijd een verkoper erbij halen. Zonder bedragen te beloven.'],

  ['agents/gemiste-aanvraag.html',
   'Opvolging: het gesprek stopt niet als de koper stopt',
   'Drie contactmomenten na een gesprek dat stilviel, met de wagen erbij. Daarna duidelijkheid, geen eindeloze herhaling.'],

  ['agents/e-mail.html',
   'E-mail: de serieuze aanvragen komen nog altijd per mail',
   'Aanvragen uit je algemene mailbox worden gelezen, gekoppeld aan een wagen en beantwoord. Inclusief de inruil die erin genoemd wordt.'],

  ['agents/whatsapp.html',
   'WhatsApp voor autobedrijven: op één bedrijfsnummer',
   'Hetzelfde systeem op het kanaal waar kopers het snelst antwoorden. Niet op de telefoon van één verkoper, maar in een dossier.'],











  ['controle.html',
   'Controle en privacy: wat een agent mag, en waar je data staat',
   'Elk gesprek leesbaar, goedkeuring per actietype, een noodstop per agent en verwerking binnen de EU. De afspraken die vastliggen voor we starten.'],

  ['faro.html',
   'Faro: het gezicht van het Helvaro-systeem',
   'Faro is niet het product maar de laag waarin je meeleest, goedkeurt en in gewone taal vraagt wat er gebeurd is.'],

  ['koppelingen/index.html',
   'Koppelingen: waar Helvaro in je bestaande software past',
   'Een afspraak die alleen bij ons staat is geen afspraak. Dit is de eerlijke stand van zaken per koppeling: live, in ontwikkeling of gepland.'],

  ['koppelingen/voorraad.html',
   'Je voorraad koppelen: antwoorden uit je eigen wagens',
   'Zonder je voorraad kan een systeem alleen algemene dingen zeggen. Met je voorraad antwoordt het met prijs, kilometerstand en uitvoering van de juiste wagen.'],

  ['koppelingen/website.html',
   'De verkoper op je eigen website',
   'Eén script op je bestaande site. Het gesprek gaat over de wagen op de pagina, vraagt contact wanneer er koopinteresse is en loopt door op WhatsApp.'],

  ['koppelingen/whatsapp-business.html',
   'WhatsApp voor je autobedrijf, op één bedrijfsnummer',
   'Het kanaal waarop kopers het snelst antwoorden, niet op de privételefoon van één verkoper maar op een nummer waar je hele team bij kan.'],

  ['koppelingen/agenda.html',
   'Je agenda koppelen: afspraken die je verkoper ziet staan',
   'Er wordt geen moment aangeboden waarvan de beschikbaarheid niet bekend is. Bevestiging, herinnering en de wagen aan de afspraak.'],
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
  <link rel="icon" href="${o}assets/favicon.ico?v=2" sizes="any">
  <link rel="icon" type="image/png" sizes="32x32" href="${o}assets/favicon-32.png?v=2">
  <link rel="icon" type="image/png" sizes="16x16" href="${o}assets/favicon-16.png?v=2">
  <link rel="icon" type="image/png" sizes="192x192" href="${o}assets/favicon-192.png?v=2">
  <link rel="apple-touch-icon" href="${o}assets/apple-touch-icon.png?v=2">
  <meta name="theme-color" content="#121212">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght\@12..96,500..700&family=Instrument+Serif:ital\@0;1&family=Inter:wght\@400;500;600&display=swap" rel="stylesheet">
  <script>/* Thema vooraf zetten zodat de pagina niet even in de verkeerde kleur flitst */
    (function(){try{var t=localStorage.getItem('helvaro_theme');document.documentElement.setAttribute('data-theme',t==='light'?'light':'dark');}catch(e){document.documentElement.setAttribute('data-theme','dark');}})();
  </script>
  <link rel="stylesheet" href="${o}css/style.css?v=97">
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
  <script src="${o}js/i18n.js?v=95"></script>

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
