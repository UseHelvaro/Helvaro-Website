# ============================================================================
# koppelingen-data.pl — de inhoud van de koppelingspagina's
# ----------------------------------------------------------------------------
# De opbouw staat in tools/build-koppelingen.pl. Pas hier de tekst aan en
# draai daarna:
#
#   perl tools/build-koppelingen.pl
#
# DE STATUS IS HET BELANGRIJKSTE VELD OP DEZE PAGINA'S.
#   live  het draait bij een echte garage en je kunt het in een demo tonen
#   bouw  er wordt aan gewerkt, maar het staat nog niet bij een klant
#   plan  we willen het bouwen, er ligt nog niets
#
# Zet nooit iets op "live" omdat het bijna af is. De hele site hangt aan dit
# onderscheid; één te vroege claim haalt de geloofwaardigheid van de rest
# onderuit, en je merkt het pas tijdens een demo.
# ============================================================================
use strict;
use utf8;
use warnings;

[
{
  slug   => 'automaat-go',
  naam   => 'AutomaaT GO',
  status => 'bouw',
  h1     => 'Helvaro en <span class="highlight">AutomaaT GO.</span>',
  lede   => 'De afspraak die uit een gesprek komt, hoort te staan waar je team toch al kijkt. Zolang iemand hem moet overtypen, wordt het systeem na twee weken stilletjes afgeschaft.',
  stapel => {
    klant      => 'Belt, appt of vult het formulier in.',
    helvaro    => 'Vangt op, herkent de auto, kwalificeert en plant in.',
    pakket     => 'Krijgt de afspraak en de klantgegevens binnen.',
    werkplaats => 'Werkt in het scherm waar ze altijd al in werkte.',
  },
  doet => [
    { titel => 'Afspraken doorschrijven',
      tekst => 'Een tijdslot dat in een gesprek wordt vastgezet, komt in de planning terecht met het juiste soort werk en de juiste duur.' },
    { titel => 'Klant en voertuig meesturen',
      tekst => 'Naam, telefoonnummer en kenteken gaan mee, zodat er geen dubbele records ontstaan en de balie niets hoeft over te typen.' },
    { titel => 'Beschikbaarheid ophalen',
      tekst => 'Voor er een moment wordt aangeboden, wordt gekeken wat er werkelijk vrij is. Dat voorkomt afspraken die later verzet moeten worden.' },
    { titel => 'Wijzigingen twee kanten op',
      tekst => 'Wordt een afspraak in het pakket verzet, dan weet het systeem dat, zodat de bevestiging en de herinnering kloppen.' },
  ],
  stand => 'Er wordt aan gewerkt, maar er draait nog geen koppeling bij een garage. Daarom staat hier "in ontwikkeling" en niet "live". Wil je hiermee starten, dan hoor je van ons wat er vandaag wel en niet kan voordat je iets tekent.',
  vandaag => [
    'Afspraken in Google Agenda, die veel bedrijven ernaast gebruiken',
    'Een dagelijkse lijst met geboekte afspraken, exporteerbaar',
    'Alle gesprekken teruglezen en exporteren',
  ],
  nog_niet => [
    'Rechtstreeks wegschrijven in het pakket',
    'Beschikbaarheid live ophalen',
    'Wijzigingen die in het pakket gebeuren terugzien',
  ],
  stand_voet => 'Werk je met dit pakket en wil je dat deze koppeling er als eerste komt? De eerste garages in de pilot bepalen de volgorde.',
  vragen => [
    { vraag => 'Moeten we overstappen naar iets anders?',
      antwoord => 'Nee. Helvaro vervangt je pakket niet en wil dat ook niet. Het staat ervoor, op de plek waar nu niemand staat.' },
    { vraag => 'Wat gebeurt er zonder koppeling?',
      antwoord => 'Dan werkt het systeem op de agenda die je eraan geeft en krijg je de afspraken door. Minder mooi, maar het werkt en je kunt het vandaag doen.' },
    { vraag => 'Wie heeft er toegang tot onze gegevens?',
      antwoord => 'Alleen wat nodig is voor de werkstromen die je aanzet, en alleen binnen de EU. Wat we bewaren en hoelang staat in het <a href="../privacybeleid.html">privacybeleid</a>.' },
    { vraag => 'Wanneer is dit af?',
      antwoord => 'Dat zeggen we liever als er een datum is die we kunnen halen. Zodra het bij een garage draait, verandert de status op deze pagina naar live.' },
  ],
  cta => 'Werk je in dit pakket?',
},

{
  slug   => 'autoflex',
  naam   => 'Autoflex',
  status => 'plan',
  h1     => 'Helvaro en <span class="highlight">Autoflex.</span>',
  lede   => 'Een geboekt tijdslot is pas werk als er een werkorder aan hangt. Deze koppeling staat op de lijst, er ligt nog geen regel code, en dat zeggen we liever nu dan tijdens een demo.',
  stapel => {
    klant      => 'Belt, appt of vult het formulier in.',
    helvaro    => 'Vangt op, herkent de auto, kwalificeert en plant in.',
    pakket     => 'Krijgt de afspraak en maakt er een werkorder van.',
    werkplaats => 'Ziet de klus staan zoals ze gewend is.',
  },
  doet => [
    { titel => 'Van afspraak naar werkorder',
      tekst => 'Het doel is dat een vastgezet tijdslot automatisch een werkorder wordt, met het soort klus en de verwachte duur erbij.' },
    { titel => 'Werkplaatsplanning als bron',
      tekst => 'De planning in het pakket bepaalt wat er aangeboden kan worden, niet een losse agenda die er naast leeft.' },
    { titel => 'Klantgegevens op één plek',
      tekst => 'Geen tweede klantenbestand dat langzaam uit de pas loopt met het eerste.' },
    { titel => 'Terugkoppeling na de klus',
      tekst => 'Wat er gedaan is en wat er opviel, is de aanleiding voor de volgende herinnering of offerte.' },
  ],
  stand => 'Dit is een plan, geen belofte. Er is nog niet aan gebouwd. Het staat hier omdat garages ons ernaar vragen en omdat we het onze volgorde laten beïnvloeden, niet omdat het bijna klaar is.',
  vandaag => [
    'Afspraken in Google Agenda',
    'Een dagelijkse lijst met geboekte afspraken, exporteerbaar',
    'Alle gesprekken teruglezen en exporteren',
  ],
  nog_niet => [
    'Werkorders aanmaken',
    'Werkplaatsplanning uitlezen',
    'Klantgegevens synchroniseren',
  ],
  stand_voet => 'Werk je met dit pakket? Zeg het in het eerste gesprek. De volgorde van wat we bouwen wordt bepaald door de garages die meedoen.',
  vragen => [
    { vraag => 'Kunnen we nu al beginnen?',
      antwoord => 'Ja, maar dan zonder deze koppeling. Veel garages starten met gemiste gesprekken of APK, want daar is geen pakketkoppeling voor nodig.' },
    { vraag => 'Wachten jullie op iets?',
      antwoord => 'Op een garage die dit pakket gebruikt en wil meedoen. Bouwen zonder iemand die het meteen gebruikt levert meestal de verkeerde koppeling op.' },
    { vraag => 'Wat als het er nooit komt?',
      antwoord => 'Dan blijft de export en de agenda de manier van werken. Dat is minder elegant, maar het houdt geen enkele werkstroom tegen.' },
    { vraag => 'Mogen we meedenken?',
      antwoord => 'Graag. Wie in de pilot zit, bepaalt mee welke velden er over moeten en in welke volgorde we bouwen.' },
  ],
  cta => 'Werk je in dit pakket?',
},

{
  slug   => 'wincar',
  naam   => 'WinCar',
  status => 'plan',
  h1     => 'Helvaro en <span class="highlight">WinCar.</span>',
  lede   => 'Klanthistorie maakt het verschil tussen een agent die vragen stelt en een agent die de klant al kent. Deze koppeling staat op de lijst en is nog niet gebouwd.',
  stapel => {
    klant      => 'Belt, appt of vult het formulier in.',
    helvaro    => 'Vangt op, herkent de auto en gebruikt de historie als context.',
    pakket     => 'Levert het voertuigdossier en de klanthistorie.',
    werkplaats => 'Krijgt een afspraak die al klopt.',
  },
  doet => [
    { titel => 'Historie als context',
      tekst => 'Wat er de vorige keer gedaan is, welke kilometerstand er stond en wat er toen is opgemerkt. Dat maakt elk bericht concreter.' },
    { titel => 'Onderhoudsintervallen',
      tekst => 'De basis onder de herinneringen voor beurten, zodat die op jouw intervallen lopen en niet op een standaardschema.' },
    { titel => 'Voertuigdossier',
      tekst => 'Alles wat bij een auto hoort op één plek, zodat het gesprek daar niet opnieuw mee hoeft te beginnen.' },
    { titel => 'Geen tweede bestand',
      tekst => 'Eén klantenbestand blijft één klantenbestand. Dat is op termijn belangrijker dan welke functie dan ook.' },
  ],
  stand => 'Nog niet begonnen. Het staat op de lijst omdat klanthistorie de werkstromen voor onderhoud en reactivering aanzienlijk scherper maakt, maar er is vandaag niets van te zien.',
  vandaag => [
    'Werken met de gegevens die je zelf aanlevert, bijvoorbeeld via een export',
    'Afspraken in Google Agenda',
    'Alle gesprekken teruglezen en exporteren',
  ],
  nog_niet => [
    'Klanthistorie live uitlezen',
    'Onderhoudsintervallen ophalen',
    'Terugschrijven naar het voertuigdossier',
  ],
  stand_voet => 'Een eenmalige export van je klantenbestand is vaak genoeg om te beginnen. Dat is geen koppeling, maar het werkt wel vandaag.',
  vragen => [
    { vraag => 'Kan het ook met een export?',
      antwoord => 'Ja. Voor de herinneringswerkstromen is een export van kentekens, klantgegevens en laatste bezoek vaak genoeg om te starten.' },
    { vraag => 'Wat gebeurt er met die gegevens?',
      antwoord => 'Ze worden binnen de EU verwerkt en alleen gebruikt voor de werkstromen die je aanzet. Details staan in het <a href="../privacybeleid.html">privacybeleid</a>.' },
    { vraag => 'Moeten we overstappen?',
      antwoord => 'Nee. We bouwen naar pakketten toe, niet ervan weg.' },
    { vraag => 'Wanneer komt dit?',
      antwoord => 'Als een garage die hiermee werkt meedoet aan de pilot. Dan pas weten we welke velden er werkelijk toe doen.' },
  ],
  cta => 'Werk je in dit pakket?',
},

{
  slug   => 'rdw-kenteken',
  naam   => 'RDW kenteken',
  status => 'bouw',
  h1     => 'Het kenteken is <span class="highlight">de helft van het gesprek.</span>',
  lede   => 'Zeven tekens leveren merk, model, bouwjaar en de datum waarop de APK verloopt. Dat is precies de context die een algemene assistent mist en die een gesprek in een werkplaats bruikbaar maakt.',
  stapel => {
    klant      => 'Noemt zijn kenteken in het gesprek.',
    helvaro    => 'Zoekt het voertuig op en gebruikt het als context.',
    pakket     => 'Het open voertuigregister levert de gegevens.',
    werkplaats => 'Krijgt een afspraak met de auto er al bij.',
  },
  doet => [
    { titel => 'Voertuig herkennen',
      tekst => 'Merk, model, bouwjaar en brandstof. De klant hoeft niet uit te leggen wat hij rijdt en jij hoeft er niet naar te raden.' },
    { titel => 'APK-vervaldatum',
      tekst => 'De aanleiding voor de hele herinneringswerkstroom, en meteen het antwoord op de vraag of een keuring nog moet.' },
    { titel => 'De juiste klus en duur',
      tekst => 'Welke auto het is, bepaalt mee hoelang een beurt duurt en welke onderdelen erbij horen.' },
    { titel => 'Minder vragen stellen',
      tekst => 'Elke vraag die je niet hoeft te stellen, is een moment minder waarop een klant afhaakt.' },
  ],
  stand => 'Hier wordt aan gewerkt. In de gesprekken die je vandaag ziet, gebruiken we het kenteken al als startpunt van het gesprek; de rechtstreekse koppeling met het register is nog niet af. Zolang dat zo is, staat hier "in ontwikkeling".',
  vandaag => [
    'Het kenteken als startpunt van het gesprek',
    'Voertuiggegevens die jij zelf aanlevert of vastlegt',
    'APK-datums uit je eigen bestand',
  ],
  nog_niet => [
    'Rechtstreeks bevragen van het open voertuigregister',
    'Automatisch bijwerken wanneer een APK is afgemeld',
    'Gegevens die verder gaan dan wat openbaar beschikbaar is',
  ],
  stand_voet => 'Belgische kentekens werken anders dan Nederlandse. Rijd je aan beide kanten van de grens, zeg dat dan in het eerste gesprek.',
  vragen => [
    { vraag => 'Slaan jullie kentekens op?',
      antwoord => 'Alleen zolang het nodig is voor het gesprek en de afspraak, en met een bewaartermijn die je zelf zet. Wat er bewaard wordt staat in het <a href="../privacybeleid.html">privacybeleid</a>.' },
    { vraag => 'Is dat zomaar toegestaan?',
      antwoord => 'Voertuiggegevens op kenteken zijn openbaar beschikbaar. Wat we opslaan en koppelen aan een persoon valt wel onder de AVG, en daar gaan we hetzelfde mee om als met de rest van je klantgegevens.' },
    { vraag => 'Werkt dit ook voor Belgische platen?',
      antwoord => 'Het Nederlandse register is een andere bron dan de Belgische. Voor Belgische bedrijven werken we vandaag met de gegevens die je zelf aanlevert.' },
    { vraag => 'Wat als het kenteken niet klopt?',
      antwoord => 'Dan wordt er doorgevraagd in plaats van geraden. Een tikfout mag geen verkeerde afspraak opleveren.' },
  ],
  cta => 'Zeven tekens, en het gesprek is al half klaar.',
},
];
