# ============================================================================
# koppelingen-data.pl — de inhoud van de koppelingspagina's
# ----------------------------------------------------------------------------
# De opbouw staat in tools/build-koppelingen.pl. Pas hier de tekst aan en
# draai daarna:
#
#   perl tools/build-koppelingen.pl
#
# DE STATUS IS HET BELANGRIJKSTE VELD OP DEZE PAGINA'S.
#   live  het draait bij een echt autobedrijf en je kunt het in een demo tonen
#   bouw  er wordt aan gewerkt, maar het staat nog niet bij een klant
#   plan  we willen het bouwen, er ligt nog niets
#
# Zet nooit iets op "live" omdat het bijna af is. De hele site hangt aan dit
# onderscheid; één te vroege claim haalt de geloofwaardigheid van de rest
# onderuit, en je merkt het pas tijdens een demo.
#
# HIER STAAN GEEN LOGO'S VAN PARTNERS. We noemen alleen koppelingen die we
# werkelijk kunnen leveren. Een logo van een pakket waarmee we "zouden kunnen"
# koppelen, is een belofte die je bij de eerste demo moet terugnemen.
# ============================================================================
use strict;
use utf8;
use warnings;

[
{
  slug   => 'voorraad',
  naam   => 'Je voorraad',
  status => 'live',
  h1     => 'Zonder je voorraad <span class="highlight">is het een chatbot.</span>',
  lede   => 'Dit is de belangrijkste koppeling van allemaal. Zonder je wagens kan een systeem alleen algemene dingen zeggen. Met je wagens kan het antwoorden op de vraag die de koper werkelijk stelt.',
  stapel => {
    klant      => 'Vraagt naar een specifieke wagen.',
    helvaro    => 'Zoekt die wagen op en antwoordt met de gegevens.',
    pakket     => 'Levert prijs, kilometerstand, uitvoering en beschikbaarheid.',
    werkplaats => 'Je verkoper krijgt een dossier met de juiste wagen erin.',
  },
  doet => [
    { titel => 'De juiste wagen erbij',
      tekst => 'Uit een link, een advertentienummer of een omschrijving. Is het niet eenduidig, dan wordt er doorgevraagd in plaats van geraden.' },
    { titel => 'Antwoorden uit jouw gegevens',
      tekst => 'Prijs, bouwjaar, kilometerstand, brandstof, transmissie en uitrusting. Precies zoals jij ze hebt vastgelegd.' },
    { titel => 'Zoeken op eisen',
      tekst => 'Een koper die op budget en carrosserie zoekt, krijgt wagens die er werkelijk staan in plaats van een filter.' },
    { titel => 'Verkocht is verkocht',
      tekst => 'Een wagen die weg is, wordt niet meer aangeboden. Dat scheelt de vervelendste mail die je kunt sturen.' },
  ],
  stand => 'Dit werkt vandaag met een voorraadbestand dat je aanlevert, bijvoorbeeld een export of een feed die je al gebruikt voor je advertenties. Een rechtstreekse koppeling met je eigen systeem staat in ontwikkeling.',
  vandaag => [
    'Een voorraadbestand dat je aanlevert, periodiek ververst',
    'De feed die je al gebruikt voor advertentiesites',
    'Antwoorden met prijs, kilometerstand en uitvoering uit dat bestand',
    'Zoeken op budget, carrosserie, brandstof en kilometers',
  ],
  nog_niet => [
    'Rechtstreeks meelezen in je eigen voorraadsysteem',
    'Een wagen reserveren of de status ervan wijzigen',
    'Gegevens die niet in je bestand staan aanvullen uit een andere bron',
  ],
  stand_voet => 'Hoe beter je voorraadgegevens gevuld zijn, hoe beter de antwoorden. Ontbrekende velden worden nooit ingevuld met een schatting.',
  vragen => [
    { vraag => 'Wat als een veld leeg is?',
      antwoord => 'Dan zegt het systeem dat het dat niet weet en geeft het de vraag door aan een verkoper. Het vult niets in.' },
    { vraag => 'Hoe vaak wordt de voorraad ververst?',
      antwoord => 'Dat hangt af van hoe je hem aanlevert. Bij een dagelijkse feed is dat dagelijks; bij een koppeling straks doorlopend.' },
    { vraag => 'Moeten we overstappen naar iets anders?',
      antwoord => 'Nee. We werken met het bestand of de feed die je al hebt.' },
    { vraag => 'Wat gebeurt er met die gegevens?',
      antwoord => 'Ze worden binnen de EU verwerkt en alleen gebruikt om aanvragen te beantwoorden. Details staan in het <a href="../privacybeleid.html">privacybeleid</a>.' },
  ],
  cta => 'Je voorraad is het halve antwoord.',
},

{
  slug   => 'website',
  naam   => 'Je website',
  status => 'live',
  h1     => 'De verkoper <span class="highlight">op je eigen site.</span>',
  lede   => 'Je website trekt al bezoekers. Het grootste deel kijkt, vindt niets om op te klikken en gaat weg. Een gesprek op het juiste moment houdt een deel daarvan vast.',
  stapel => {
    klant      => 'Bekijkt een wagen op je site.',
    helvaro    => 'Beantwoordt zijn vraag en zet een afspraak vast.',
    pakket     => 'Je website blijft je website, met één script erbij.',
    werkplaats => 'Je verkoper krijgt het dossier binnen.',
  },
  doet => [
    { titel => 'Meekijken op de pagina',
      tekst => 'Staat de bezoeker op een wagen, dan gaat het gesprek daarover. Hij hoeft niet uit te leggen welke auto hij bedoelt.' },
    { titel => 'Vragen beantwoorden',
      tekst => 'Beschikbaarheid, gegevens, openingsuren en wat er bij een bezoek komt kijken.' },
    { titel => 'Contact vragen wanneer het past',
      tekst => 'Bij echte koopinteresse, en dan is een mailadres of een telefoonnummer genoeg. Niet allebei, en niet bij iemand die alleen rondkijkt.' },
    { titel => 'Doorgeven aan een ander kanaal',
      tekst => 'Wil hij verder op WhatsApp, dan gaat het gesprek mee. Met de wagen en alles wat al gezegd is.' },
  ],
  stand => 'Dit draait. Het is één script op je bestaande site; je hoeft niets te migreren en je CMS blijft wat het is.',
  vandaag => [
    'Een gesprek op elke pagina van je site',
    'De wagen van de pagina als context',
    'Contactgegevens vragen bij koopinteresse',
    'Overstappen naar WhatsApp met behoud van het gesprek',
  ],
  nog_niet => [
    'Een volledige voorraadmodule op je site vervangen',
    'Het uiterlijk van je website aanpassen',
    'Betalingen of reserveringen met aanbetaling',
  ],
  stand_voet => 'De toon en de openingszin stel je zelf in. Een dorpsgarage klinkt anders dan een merkdealer, en dat hoort ook.',
  vragen => [
    { vraag => 'Wordt onze site trager?',
      antwoord => 'Het script laadt apart van je pagina. Je bezoeker ziet je site zoals altijd, en het gesprek komt daarna.' },
    { vraag => 'Moeten wij iets bouwen?',
      antwoord => 'Eén regel in je website plakken. De rest zetten wij op.' },
    { vraag => 'Wordt iedereen om gegevens gevraagd?',
      antwoord => 'Nee. Wie alleen rondkijkt, wordt met rust gelaten. Dat levert meer op dan iedereen een formulier voorhouden.' },
    { vraag => 'Kunnen we het uitzetten?',
      antwoord => 'Ja, per direct en zonder ons te bellen. Dat geldt voor elk kanaal.' },
  ],
  cta => 'Je bezoekers zijn er al.',
},

{
  slug   => 'whatsapp-business',
  naam   => 'WhatsApp',
  status => 'live',
  h1     => 'Eén nummer voor het bedrijf, <span class="highlight">niet voor één verkoper.</span>',
  lede   => 'WhatsApp is het kanaal waarop kopers het snelst antwoorden. In de meeste autobedrijven staat het op de privételefoon van één verkoper, en daarmee is het klantcontact van die verkoper en niet van het bedrijf.',
  stapel => {
    klant      => 'Stuurt een bericht vanaf een advertentie.',
    helvaro    => 'Antwoordt, kwalificeert en zet de afspraak vast.',
    pakket     => 'Eén zakelijk WhatsApp-nummer van je bedrijf.',
    werkplaats => 'Elke verkoper kan meelezen en overnemen.',
  },
  doet => [
    { titel => 'Eén bedrijfsnummer',
      tekst => 'Alle gesprekken op één zakelijk nummer, waar je hele team bij kan en waar alles bewaard blijft.' },
    { titel => 'Gesprekken die doorlopen',
      tekst => 'Begon hij op je website, dan gaat het gesprek mee. Geen tweede keer uitleggen welke wagen hij bedoelt.' },
    { titel => 'Foto\'s beide kanten op',
      tekst => 'Extra beelden van de wagen naar de koper, foto\'s van zijn inruil naar jou. Dat gaat hier vanzelf.' },
    { titel => 'Overnemen zonder knip',
      tekst => 'Je verkoper stapt in het lopende gesprek. De koper merkt niet dat er iemand anders typt.' },
  ],
  stand => 'Dit draait. Je krijgt een zakelijk nummer, of we gebruiken een nummer dat je al voor het bedrijf hebt.',
  vandaag => [
    'Eén zakelijk nummer voor het hele bedrijf',
    'Gesprekken die doorlopen vanaf je website',
    'Foto\'s ontvangen en versturen',
    'Meelezen en overnemen door elke verkoper',
  ],
  nog_niet => [
    'Berichten sturen naar mensen die zich niet zelf gemeld hebben',
    'Campagnes of aanbiedingen naar je hele bestand',
    'Gesprekken overzetten vanaf de privételefoon van een verkoper',
  ],
  stand_voet => 'WhatsApp heeft eigen regels over wie je wanneer mag aanschrijven. We houden ons daaraan, ook als dat betekent dat iets niet kan.',
  vragen => [
    { vraag => 'Kunnen we ons huidige nummer houden?',
      antwoord => 'Een zakelijk nummer wel. Een privénummer van een verkoper niet, en dat is maar goed ook.' },
    { vraag => 'Mogen we iedereen appen?',
      antwoord => 'Nee. Alleen mensen die zelf contact hebben opgenomen. Dat is geen keuze van ons maar een regel van WhatsApp.' },
    { vraag => 'Ziet de klant dat het geen mens is?',
      antwoord => 'We doen niet alsof. Je bepaalt zelf hoe het systeem zich voorstelt en wanneer het een verkoper erbij haalt.' },
    { vraag => 'Wie kan de gesprekken lezen?',
      antwoord => 'De mensen bij jou die je toegang geeft. Alles blijft bij het bedrijf, ook als een verkoper vertrekt.' },
  ],
  cta => 'Daar waar je koper toch al zit.',
},

{
  slug   => 'agenda',
  naam   => 'Je agenda',
  status => 'live',
  h1     => 'Een afspraak die alleen bij ons staat, <span class="highlight">is geen afspraak.</span>',
  lede   => 'Een bezichtiging of proefrit is pas iets waard als je verkoper er die ochtend op kan rekenen. Daarom gaat elke afspraak naar de agenda waar je team toch al in kijkt.',
  stapel => {
    klant      => 'Kiest een moment dat hem past.',
    helvaro    => 'Kijkt wat vrij is en zet het vast.',
    pakket     => 'Je agenda is de bron van de beschikbaarheid.',
    werkplaats => 'Je verkoper ziet de afspraak staan waar hij altijd kijkt.',
  },
  doet => [
    { titel => 'Alleen wat vrij is',
      tekst => 'Er wordt geen moment aangeboden waarvan de beschikbaarheid niet bekend is. Liever geen voorstel dan een voorstel dat je moet terugnemen.' },
    { titel => 'De wagen aan de afspraak',
      tekst => 'Welke wagen het betreft, staat in de afspraak. Zo kan dezelfde auto niet twee keer beloofd worden.' },
    { titel => 'Bevestigen en herinneren',
      tekst => 'De koper krijgt een bevestiging met tijd en plaats, en een herinnering de dag ervoor.' },
    { titel => 'Verzetten in plaats van verliezen',
      tekst => 'Wie niet kan, krijgt twee alternatieven. Een verzette afspraak is werk dat behouden blijft.' },
  ],
  stand => 'Dit werkt vandaag met Google Agenda. Andere agenda\'s bekijken we per geval; wat we niet kunnen lezen, gebruiken we niet als bron.',
  vandaag => [
    'Google Agenda als bron van beschikbaarheid',
    'Afspraken wegschrijven met de wagen erbij',
    'Bevestiging en herinnering naar de koper',
    'Verzetten met behoud van het dossier',
  ],
  nog_niet => [
    'Andere agendapakketten dan Google Agenda',
    'Per verkoper een eigen beschikbaarheid instellen',
    'Aanbetalingen of reserveringskosten',
  ],
  stand_voet => 'Kun je je beschikbaarheid niet delen, dan stelt het systeem geen tijden voor maar vraagt het wanneer het de koper past en geeft dat door.',
  vragen => [
    { vraag => 'Wat als we geen digitale agenda gebruiken?',
      antwoord => 'Dan worden er geen tijden voorgesteld. De voorkeur van de koper wordt opgehaald en doorgegeven aan je verkoper.' },
    { vraag => 'Kan het buiten onze openingsuren boeken?',
      antwoord => 'Alleen binnen de grenzen die jij zet. Een gesprek om middernacht kan, een afspraak om middernacht niet.' },
    { vraag => 'Zien jullie onze hele agenda?',
      antwoord => 'Alleen wat nodig is om te weten of een moment vrij is. Wat er in een afspraak staat, hoeft daar niet voor.' },
    { vraag => 'Wat bij een dubbele boeking?',
      antwoord => 'Omdat de wagen aan de afspraak hangt en de agenda de bron is, kan dat niet ontstaan vanuit het systeem.' },
  ],
  cta => 'De afspraak hoort in je agenda.',
},
];
