# ============================================================================
# agents-data.pl — de inhoud van de werkstroompagina's
# ----------------------------------------------------------------------------
# Acht werkstromen voor autobedrijven. Alleen tekst; de opbouw van de pagina
# staat in tools/build-agents.pl. Pas hier iets aan en draai daarna:
#
#   perl tools/build-agents.pl
#
# Huisstijl: korte spanningsparen, geen uitroeptekens, geen gedachtestreepjes
# in zinnen, en nooit "de AI".
#
# TWEE REGELS DIE HIER ZWAAR WEGEN
#   1. Helvaro verzint nooit voertuiggegevens. Prijs, kilometerstand,
#      uitvoering en beschikbaarheid komen uit de voorraad van de dealer.
#      Staat het er niet in, dan zegt het dat het dat niet weet.
#   2. De verkoper kan altijd overnemen. Elke werkstroom eindigt bij een mens
#      zodra er onderhandeld, ingeruild of getwijfeld wordt.
# ============================================================================
use strict;
use utf8;
use warnings;

[
# ── 01 ─────────────────────────────────────────────────────────────────────
{
  slug => 'nieuwe-aanvraag',
  nr   => '01',
  naam => 'Nieuwe aanvraag',
  h1   => 'Een koper vraagt naar een auto. <span class="highlight">Wie antwoordt er als eerste?</span>',
  lede => 'De meeste aanvragen komen buiten je openingsuren binnen, en bijna nooit bij één bedrijf tegelijk. Wie binnen een paar minuten antwoordt met de juiste gegevens erbij, krijgt de afspraak. De rest krijgt een gelezen bericht.',

  probleem => {
    titel => 'De eerste reactie beslist, niet de beste prijs.',
    tekst => [
      'Iemand ziet je advertentie ’s avonds, vraagt of de wagen er nog staat en stuurt dezelfde vraag naar drie andere bedrijven. Morgenochtend om negen uur is hij al ergens langs geweest, of heeft hij al een afspraak staan.',
      'Het probleem is niet dat je verkoper traag is. Hij stond bij een klant, was op proefrit of was gewoon naar huis. Aanvragen komen alleen niet alleen tijdens kantooruren binnen.',
      'Wat een koper in die eerste minuten wil weten is klein: staat hij er nog, wat kost hij, en wanneer kan ik komen kijken.',
    ],
    gevolgen => [
      'Een aanvraag van 21:43 die om 09:15 beantwoord wordt, is meestal al weg.',
      'Je weet niet eens hoeveel er ’s avonds binnenkomen.',
      'De wagen staat nog, maar de koper is bij iemand anders gaan kijken.',
    ],
  },

  werkstroom_sub => 'Van binnengekomen vraag tot vastgezette afspraak, zonder dat er iemand achter een scherm hoeft te zitten.',
  stappen => [
    { kop => 'De vraag komt binnen',
      tekst => 'Via het formulier op je site, via WhatsApp of per mail. Alle drie komen ze in dezelfde stroom terecht, met dezelfde behandeling.' },
    { kop => 'De auto wordt erbij gehaald',
      tekst => 'Welke wagen bedoelt hij. Staat er een link bij, dan is dat duidelijk. Zegt hij alleen "de blauwe X5", dan wordt er doorgevraagd tot het klopt.' },
    { kop => 'Antwoord met de gegevens erbij',
      tekst => 'Beschikbaarheid, prijs, kilometerstand en uitvoering komen uit jouw voorraad. Niet uit een schatting en niet uit een algemeen praatje.' },
    { kop => 'De vragen erna worden beantwoord',
      tekst => 'Trekhaak, onderhoudshistoriek, garantie, eerste eigenaar. Wat in de gegevens staat, wordt beantwoord. Wat er niet in staat, gaat naar een verkoper.' },
    { kop => 'Een moment aanbieden',
      tekst => 'Geen "neem gerust contact op", maar twee concrete momenten waarop de wagen en iemand van je team beschikbaar zijn.' },
    { kop => 'Het dossier staat klaar',
      tekst => 'Naam, wagen, budget als hij dat noemde, termijn, afspraak en het hele gesprek. Je verkoper begint niet bij nul.' },
  ],

  gesprek => {
    kanaal => 'Website · 21:43',
    regels => [
      ['Koper',   'Staat die BMW X5 er nog?'],
      ['Helvaro', 'Ja, de X5 xDrive30d uit 2021 staat er nog. 82.000 km, automaat, diesel, € 48.900.'],
      ['Koper',   'Is er onderhoudshistoriek?'],
      ['Helvaro', 'Ja, volledige historiek aanwezig, laatste beurt op 78.400 km. Wil je hem komen bekijken?'],
      ['Koper',   'Zaterdag zou goed uitkomen.'],
      ['Helvaro', 'Zaterdag kan om 11:00 of om 14:00. Wat past het beste?'],
      ['Koper',   '14:00'],
    ],
    uitkomst => ['Afspraak vastgezet', 'Zaterdag 14:00 · BMW X5 xDrive30d · dossier aangemaakt'],
  },

  opbrengst_titel => 'De aanvraag die anders tot morgen bleef liggen.',
  opbrengst => [
    { titel => 'Je bent er als eerste',
      tekst => 'Niet omdat je sneller typt, maar omdat er altijd iemand is. Ook om tien uur ’s avonds en op zondagochtend.' },
    { titel => 'De koper krijgt echte gegevens',
      tekst => 'Prijs, kilometerstand en uitvoering komen uit je voorraad. Dat scheelt de teleurstelling die je anders pas op de parking merkt.' },
    { titel => 'Je verkoper krijgt een dossier',
      tekst => 'In plaats van een losse mail met "is deze nog beschikbaar" ligt er een gesprek met een wagen, een termijn en een afspraak.' },
    { titel => 'Je ziet hoeveel er binnenkomt',
      tekst => 'Voor het eerst een getal op iets dat nu nergens geteld wordt: hoeveel aanvragen, via welk kanaal, op welk uur.' },
  ],

  systeem => {
    tekst => 'Dit is de werkstroom waar bijna alles begint. De andere zeven takken hier vanaf zodra duidelijk is wat de koper wil.',
    lagen => [
      ['opvangen',  'Opvangen',  'Website, WhatsApp en e-mail in één stroom.'],
      ['begrijpen', 'Begrijpen', 'Welke wagen, en wat de koper erover vraagt.'],
      ['handelen',  'Handelen',  'Antwoorden, doorvragen en een moment vastzetten.'],
      ['meten',     'Meten',     'Aanvragen per kanaal, per uur, en wat ervan een afspraak werd.'],
    ],
    buren => [
      ['proefrit',         'Zet de bezichtiging om in een proefrit met een tijdslot.'],
      ['gemiste-aanvraag', 'Pakt op wat na het eerste antwoord stil blijft.'],
      ['whatsapp',         'Zet het gesprek door naar WhatsApp wanneer de koper dat wil.'],
    ],
  },

  grenzen => [
    'Het verzint geen voertuiggegevens. Wat niet in je voorraad staat, gaat naar een verkoper.',
    'Het onderhandelt niet over de prijs.',
    'Het belooft geen inruilwaarde en geen financieringsgoedkeuring.',
    'Het zet geen afspraak vast op een moment waarvan de beschikbaarheid niet bekend is.',
  ],

  cta => 'Je volgende aanvraag komt vanavond binnen.',
},

# ── 02 ─────────────────────────────────────────────────────────────────────
{
  slug => 'proefrit',
  nr   => '02',
  naam => 'Proefrit',
  h1   => 'Een proefrit is de afspraak <span class="highlight">die er echt toe doet.</span>',
  lede => 'Wie achter het stuur zit, koopt vaker. Toch gaat het vaakst mis bij het plannen ervan: de wagen staat er niet, er is niemand vrij, of het heen en weer duurt zo lang dat de koper afhaakt.',

  probleem => {
    titel => 'Tussen "ik wil eens rijden" en een datum zitten te veel stappen.',
    tekst => [
      'Een koper vraagt of hij kan proefrijden. Dan moet iemand kijken of de wagen er staat, of hij niet uitgeleend is en of er een verkoper vrij is. Dat kost drie berichten en een halve dag.',
      'In die halve dag heeft hij bij een ander bedrijf al gereden. Niet omdat dat bedrijf beter is, maar omdat het antwoord daar sneller kwam.',
      'Bovendien gaat het regelmatig fout: twee kopers krijgen hetzelfde tijdslot, of de wagen blijkt net verkocht.',
    ],
    gevolgen => [
      'De koper rijdt bij de concurrent en koopt daar ook.',
      'Dubbele afspraken op dezelfde wagen leveren een slechte eerste indruk op.',
      'Een proefrit die niet doorgaat, kost je verkoper een blok in zijn agenda.',
    ],
  },

  werkstroom_sub => 'Eerst kijken of het kan, dan pas een moment noemen.',
  stappen => [
    { kop => 'Welke wagen precies',
      tekst => 'Een proefrit gaat over één specifieke auto uit je voorraad, niet over een model. Dat wordt eerst vastgesteld.' },
    { kop => 'Kan die wagen rijden',
      tekst => 'Staat hij er, is hij niet gereserveerd en is hij niet al uitgeleend. Is het antwoord nee, dan wordt er geen tijdslot aangeboden.' },
    { kop => 'Wat de koper nodig heeft',
      tekst => 'Rijbewijs meenemen, en soms een legitimatie. Dat staat in de bevestiging, zodat niemand voor niets komt.' },
    { kop => 'Twee momenten voorstellen',
      tekst => 'Uit de beschikbaarheid die jij aanlevert. Nooit een moment noemen waarvan het systeem niet weet of het vrij is.' },
    { kop => 'Vastzetten en bevestigen',
      tekst => 'De afspraak gaat in de agenda met de wagen erbij, en de koper krijgt een bevestiging met tijd, plaats en wat hij moet meenemen.' },
    { kop => 'Herinneren',
      tekst => 'Een bericht de dag ervoor. Wie niet kan, krijgt meteen twee alternatieven in plaats van een lege plek in je agenda.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · dinsdagavond',
    regels => [
      ['Koper',   'Kan ik met die Golf GTI eens rijden?'],
      ['Helvaro', 'Dat kan. Het gaat om de Golf GTI uit 2022 met 41.000 km, klopt dat?'],
      ['Koper',   'Ja die.'],
      ['Helvaro', 'Hij staat beschikbaar. Donderdag om 16:30 of zaterdag om 10:00 kan er iemand mee. Neem je rijbewijs mee.'],
      ['Koper',   'Zaterdag 10:00.'],
      ['Helvaro', 'Genoteerd. Zaterdag 10:00, Golf GTI, ongeveer een half uur rijden. Je krijgt vrijdag nog een herinnering.'],
    ],
    uitkomst => ['Proefrit vastgezet', 'Zaterdag 10:00 · Golf GTI 2022 · rijbewijs meenemen'],
  },

  opbrengst_titel => 'Meer mensen achter het stuur.',
  opbrengst => [
    { titel => 'Minder heen en weer',
      tekst => 'Van "kan ik rijden" naar een datum in twee berichten in plaats van in twee dagen.' },
    { titel => 'Geen dubbele reserveringen',
      tekst => 'Omdat de wagen aan de afspraak hangt, kan hij niet per ongeluk twee keer beloofd worden.' },
    { titel => 'Minder lege blokken',
      tekst => 'Een herinnering de dag ervoor haalt het merendeel van de niet-verschijners eruit, en wie niet kan verzet in plaats van weg te blijven.' },
    { titel => 'De verkoper weet wie er komt',
      tekst => 'Naam, wagen, wat er al besproken is en of er een inruil in het spel zit. Dat scheelt het eerste kwartier van elk gesprek.' },
  ],

  systeem => {
    tekst => 'Een proefrit is een afspraak met een wagen eraan vast. Daarom gaat deze werkstroom altijd langs je voorraad voordat er een moment genoemd wordt.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Welke wagen, en of die vrij is.'],
      ['handelen',  'Handelen',  'Voorstellen, vastzetten, bevestigen en herinneren.'],
      ['koppelen',  'Koppelen',  'De afspraak komt in de agenda waar je team in werkt.'],
    ],
    buren => [
      ['nieuwe-aanvraag', 'Levert de koper aan die verder wil dan kijken.'],
      ['inruil',          'Vraagt vooraf naar de wagen die hij zelf meebrengt.'],
      ['financiering',    'Beantwoordt de financieringsvraag die vaak bij de proefrit hoort.'],
    ],
  },

  grenzen => [
    'Het biedt geen tijdslot aan zonder dat de beschikbaarheid bekend is.',
    'Het controleert geen rijbewijs. Dat gebeurt bij het ophalen van de sleutel.',
    'Het laat geen proefrit toe buiten de regels die jij hebt vastgelegd.',
    'Een proefrit zonder begeleiding is jouw beslissing, niet die van het systeem.',
  ],

  cta => 'Van "ik wil eens rijden" naar een datum.',
},

# ── 03 ─────────────────────────────────────────────────────────────────────
{
  slug => 'voertuigadvies',
  nr   => '03',
  naam => 'Voertuigadvies',
  h1   => 'Niet elke koper weet al <span class="highlight">welke auto hij wil.</span>',
  lede => 'Een deel van je bezoekers zoekt op eisen in plaats van op een model: automaat, ongeveer dertigduizend, niet te veel kilometers. Die vraag beantwoorden kost je verkoper tien minuten zoeken, en gebeurt daarom vaak niet.',

  probleem => {
    titel => 'Een zoekfilter is geen verkoper.',
    tekst => [
      'Op je website staat een filter met merk, prijs en brandstof. Wie precies weet wat hij zoekt, komt daar wel uit. Wie het niet weet, klikt drie keer en gaat weg.',
      'Een koper die zegt "ik zoek een automaat rond de dertigduizend met minder dan honderdduizend kilometer" stelt eigenlijk een verkoopvraag. Alleen staat er op dat moment niemand om hem te beantwoorden.',
      'En dit is precies het soort koper dat nog niet aan één bedrijf vastzit. Wie hem helpt kiezen, verkoopt.',
    ],
    gevolgen => [
      'Bezoekers die niets vinden, komen niet terug.',
      'Wagens die niet in het eerste filter passen, worden nooit bekeken.',
      'Je verkoper zoekt drie keer per dag hetzelfde uit.',
    ],
  },

  werkstroom_sub => 'Van eisen naar drie wagens die er echt staan.',
  stappen => [
    { kop => 'Uitvragen wat hij zoekt',
      tekst => 'Budget, carrosserie, brandstof, transmissie, kilometers en waarvoor hij de wagen gebruikt. Vier vragen, geen formulier van twintig velden.' },
    { kop => 'Zoeken in jouw voorraad',
      tekst => 'Alleen wagens die er werkelijk staan. Geen modellen die je misschien kunt bestellen en geen wagens die vorige week verkocht zijn.' },
    { kop => 'Een paar tonen, niet dertig',
      tekst => 'Drie tot vijf wagens met de gegevens die de keuze bepalen. Een lijst van dertig is hetzelfde als geen antwoord.' },
    { kop => 'Uitleggen waarom',
      tekst => 'Waarom deze drie bij zijn eisen passen, en waar ze van elkaar verschillen. Dat is het stuk dat een filter niet doet.' },
    { kop => 'Doorgaan waar hij kiest',
      tekst => 'Kiest hij er één, dan loopt het gesprek door als een gewone aanvraag: vragen, afspraak, dossier.' },
    { kop => 'Niets gevonden is ook een antwoord',
      tekst => 'Past er niets, dan wordt dat gezegd. Met de vraag of hij bericht wil als er wel iets binnenkomt.' },
  ],

  gesprek => {
    kanaal => 'Website · zondagmiddag',
    regels => [
      ['Koper',   'Ik zoek een automaat rond de 30.000 euro, minder dan 100.000 km.'],
      ['Helvaro', 'Dat kan ik nakijken. Heb je een voorkeur voor carrosserie of brandstof?'],
      ['Koper',   'Liefst een SUV, benzine of hybride.'],
      ['Helvaro', 'Dan passen deze drie: een Volvo XC40 T4 uit 2021 met 62.000 km voor € 31.500, een Kia Sportage hybride uit 2022 met 48.000 km voor € 29.900 en een Peugeot 3008 uit 2021 met 71.000 km voor € 27.950. De Kia is de jongste, de Peugeot de voordeligste.'],
      ['Koper',   'Die Volvo ziet er goed uit.'],
      ['Helvaro', 'Wil je hem komen bekijken? Donderdag om 17:00 of zaterdag om 11:30 kan.'],
    ],
    uitkomst => ['Van zoeken naar kiezen', 'Volvo XC40 T4 · bezichtiging voorgesteld'],
  },

  opbrengst_titel => 'Bezoekers die anders doorklikten.',
  opbrengst => [
    { titel => 'De twijfelaar blijft',
      tekst => 'Wie nog geen model op het oog heeft, is de makkelijkste koper om te helpen en de makkelijkste om te verliezen.' },
    { titel => 'Wagens uit de tweede rij',
      tekst => 'Voorraad die buiten het eerste filter valt, komt toch in beeld wanneer hij bij de eisen past.' },
    { titel => 'Minder zoekwerk',
      tekst => 'Je verkoper hoeft niet meer door de lijst te scrollen voor een vraag die drie keer per dag terugkomt.' },
    { titel => 'Je ziet waar vraag naar is',
      tekst => 'Welke eisen vaak terugkomen en waar je niets voor had staan. Dat is bruikbare informatie voor je inkoop.' },
  ],

  systeem => {
    tekst => 'Deze werkstroom leunt volledig op je voorraadgegevens. Hoe beter die gevuld zijn, hoe scherper het advies.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Budget, type, gebruik en wat de koper echt belangrijk vindt.'],
      ['handelen',  'Handelen',  'Zoeken, een paar wagens tonen en het verschil uitleggen.'],
      ['koppelen',  'Koppelen',  'De voorraad is de bron, niet een los overzicht.'],
    ],
    buren => [
      ['nieuwe-aanvraag',  'Neemt het over zodra de koper een wagen kiest.'],
      ['proefrit',         'Zet de gekozen wagen om in een rit.'],
      ['gemiste-aanvraag', 'Komt terug bij wie wel keek maar niet koos.'],
    ],
  },

  grenzen => [
    'Het toont alleen wagens die in je voorraad staan.',
    'Het belooft geen wagen die nog binnenkomt.',
    'Het geeft geen technisch advies over betrouwbaarheid of verbruik dat niet in je gegevens staat.',
    'Het onderhandelt niet en geeft geen korting om een keuze te forceren.',
  ],

  cta => 'Help hem kiezen voor iemand anders dat doet.',
},

# ── 04 ─────────────────────────────────────────────────────────────────────
{
  slug => 'inruil',
  nr   => '04',
  naam => 'Inruil',
  h1   => 'Bijna elke koper <span class="highlight">brengt een auto mee.</span>',
  lede => 'De inruil bepaalt vaak of een deal doorgaat, en hij komt bijna altijd pas ter sprake als de koper al op de parking staat. Dan moet je verkoper een gesprek voeren waar hij zich niet op heeft kunnen voorbereiden.',

  probleem => {
    titel => 'De inruil komt te laat ter sprake.',
    tekst => [
      'Een koper is enthousiast over een wagen en vraagt pas aan het eind wat zijn eigen auto nog waard is. Vanaf dat moment gaat het gesprek niet meer over de wagen die hij wil, maar over de wagen die hij kwijt wil.',
      'Zonder gegevens vooraf kan niemand daar iets zinnigs over zeggen. Er komt een voorzichtige uitspraak, de koper vindt die te laag, en de goede sfeer is weg.',
      'Het scheelt enorm als merk, bouwjaar, kilometerstand en staat al bekend zijn voordat hij binnenstapt.',
    ],
    gevolgen => [
      'Een deal die klaar leek, strandt op een bedrag dat niemand had voorbereid.',
      'Je verkoper moet ter plekke schatten, en dat kost hem marge of de klant.',
      'De koper vertrekt om "er nog eens over na te denken".',
    ],
  },

  werkstroom_sub => 'De gegevens ophalen voordat het gesprek over geld gaat.',
  stappen => [
    { kop => 'De vraag komt vanzelf',
      tekst => 'Zodra een koper serieus wordt over een wagen, komt de vraag of hij zijn huidige auto kan inruilen. Daar wordt op ingegaan in plaats van omheen.' },
    { kop => 'Welke auto brengt hij mee',
      tekst => 'Merk, model, bouwjaar, brandstof en kilometerstand. Bij een Nederlands of Belgisch kenteken scheelt dat een paar vragen.' },
    { kop => 'Staat en historiek',
      tekst => 'Onderhoudsboekje, schadeverleden, aantal eigenaren, bijzonderheden. Precies de punten die het bedrag later bepalen.' },
    { kop => 'Foto’s erbij',
      tekst => 'Vier foto’s rondom en één van de kilometerteller. Via WhatsApp of mail is dat voor de meeste mensen de makkelijkste stap.' },
    { kop => 'Naar de verkoper',
      tekst => 'Hier stopt het systeem. Een bedrag noemen is mensenwerk, en dat blijft zo. Wat er ligt is een compleet beeld om mee te beginnen.' },
    { kop => 'De afspraak eromheen',
      tekst => 'De inruil hangt aan de bezichtiging of proefrit, zodat beide wagens tegelijk op de planning staan.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · na een bezichtigingsaanvraag',
    regels => [
      ['Koper',   'Kan ik mijn huidige auto inruilen?'],
      ['Helvaro', 'Zeker, dat kijkt een verkoper na. Wat rijd je nu?'],
      ['Koper',   'Een Audi A4 uit 2018, diesel.'],
      ['Helvaro', 'Hoeveel kilometer staat erop, en is de onderhoudshistoriek compleet?'],
      ['Koper',   '134.000, alles bij de dealer onderhouden.'],
      ['Helvaro', 'Genoteerd. Stuur je vier foto’s rondom en één van de teller? Dan kan onze verkoper zaterdag meteen een bedrag met je bespreken.'],
      ['Koper',   'Foto’s verstuurd'],
    ],
    uitkomst => ['Bij het dossier', 'Audi A4 2018 · 134.000 km · foto’s binnen · verkoper bepaalt het bedrag'],
  },

  opbrengst_titel => 'Het gesprek over geld begint voorbereid.',
  opbrengst => [
    { titel => 'Geen schatting op de parking',
      tekst => 'Je verkoper heeft merk, jaar, kilometers, historiek en beeld voor de koper binnenstapt.' },
    { titel => 'Minder verrassingen',
      tekst => 'Schade of een dubieuze historiek komt boven water voordat er een bedrag op tafel ligt.' },
    { titel => 'Twee wagens, één afspraak',
      tekst => 'De inruil hangt aan de bezichtiging, dus er is tijd ingepland om er ook echt naar te kijken.' },
    { titel => 'De koper voelt zich serieus genomen',
      tekst => 'Zijn auto is voor hem geen bijzaak. Er meteen naar vragen scheelt argwaan later in het gesprek.' },
  ],

  systeem => {
    tekst => 'Dit is de werkstroom waarin het systeem het duidelijkst stopt en een mens begint. Het haalt op, het beoordeelt niet.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Welke auto hij meebrengt en in welke staat.'],
      ['handelen',  'Handelen',  'Doorvragen, foto’s ophalen en doorgeven aan een verkoper.'],
      ['koppelen',  'Koppelen',  'De inruil hangt aan het dossier van de wagen die hij wil kopen.'],
    ],
    buren => [
      ['proefrit',     'Plant het moment waarop beide wagens er staan.'],
      ['financiering', 'Werkt samen wanneer de inruil deel van de financiering wordt.'],
      ['e-mail',       'Vangt de inruilvraag op die per mail binnenkomt, vaak met foto’s.'],
    ],
  },

  grenzen => [
    'Het noemt nooit een inruilwaarde, ook niet bij benadering.',
    'Het beoordeelt geen schade en geen staat op basis van foto’s.',
    'Het doet geen uitspraak over wat jouw marge toelaat.',
    'Het belooft niet dat de inruil wordt overgenomen.',
  ],

  cta => 'Weet wat hij meebrengt voor hij voorrijdt.',
},

# ── 05 ─────────────────────────────────────────────────────────────────────
{
  slug => 'financiering',
  nr   => '05',
  naam => 'Financiering',
  h1   => '"Wat kost dat per maand?" <span class="highlight">Is een koopsignaal.</span>',
  lede => 'Wie naar een maandbedrag vraagt, denkt al na over bezit. Toch is dit de vraag waar het gesprek het vaakst op stilvalt, omdat niemand er zonder voorbehoud iets over durft te zeggen.',

  probleem => {
    titel => 'De sterkste vraag krijgt het vaagste antwoord.',
    tekst => [
      'Een koper vraagt wat een wagen hem per maand kost. Het eerlijke antwoord hangt af van looptijd, inbreng, inruil en een goedkeuring die nog moet komen. Dus zegt iedereen "dat hangt ervan af", en daar stopt het.',
      'Het gevolg is dat een koper met een duidelijk koopsignaal met minder informatie vertrekt dan waarmee hij binnenkwam.',
      'Wat wel kan: uitleggen hoe het werkt, ophalen wat nodig is, en het gesprek op tijd bij een mens leggen. Dat is genoeg om hem vast te houden.',
    ],
    gevolgen => [
      'Een koopsignaal dat doodloopt in een voorbehoud.',
      'De koper rekent zelf iets uit op een vergelijkingssite en komt niet terug.',
      'Je verkoper krijgt de vraag pas te horen als de koper al is afgehaakt.',
    ],
  },

  werkstroom_sub => 'Uitleggen wat kan, ophalen wat nodig is, en op tijd een mens erbij halen.',
  stappen => [
    { kop => 'De vraag wordt herkend',
      tekst => 'Per maand, leasen, afbetalen, voorschot. In alle gevallen gaat het over hetzelfde en wordt het als koopsignaal behandeld.' },
    { kop => 'Uitleggen waar het van afhangt',
      tekst => 'Looptijd, eigen inbreng, eventuele inruil en de goedkeuring van de kredietgever. Geen bedrag, wel duidelijkheid.' },
    { kop => 'Ophalen wat nodig is',
      tekst => 'Welke wagen, welke termijn hij in gedachten heeft en of er een inruil bij komt. Meer is er in deze fase niet nodig.' },
    { kop => 'Alleen wat vastligt',
      tekst => 'Heb jij tarieven of voorbeeldberekeningen vastgelegd, dan worden die genoemd. Zo niet, dan wordt er niets berekend.' },
    { kop => 'Naar een mens',
      tekst => 'Financiering is een gesprek met gevolgen. Het dossier gaat naar je verkoper, met de wagen en de wensen erbij.' },
    { kop => 'De afspraak erbij',
      tekst => 'Vaak is de kortste route een afspraak waarin de financiering en de wagen samen besproken worden.' },
  ],

  gesprek => {
    kanaal => 'Website · woensdagavond',
    regels => [
      ['Koper',   'Wat kost die Volvo per maand?'],
      ['Helvaro', 'Dat hangt af van de looptijd, je eigen inbreng en of je iets inruilt. Onze verkoper rekent dat voor je uit. Denk je aan 36, 48 of 60 maanden?'],
      ['Koper',   '48 maanden, en ik ruil mijn Golf in.'],
      ['Helvaro', 'Genoteerd. Zal ik een afspraak zetten waarin hij de financiering en je inruil samen met je doorneemt? Donderdag 17:00 of zaterdag 11:00.'],
      ['Koper',   'Donderdag.'],
    ],
    uitkomst => ['Naar de verkoper', 'Volvo XC40 · 48 maanden · inruil Golf · donderdag 17:00'],
  },

  opbrengst_titel => 'Een koopsignaal dat niet doodloopt.',
  opbrengst => [
    { titel => 'De vraag krijgt een vervolg',
      tekst => 'In plaats van "dat hangt ervan af" komt er een afspraak waarin het wel uitgerekend wordt.' },
    { titel => 'Je verkoper weet het vooraf',
      tekst => 'Welke wagen, welke looptijd, welke inruil. Hij kan de berekening klaar hebben voor de koper zit.' },
    { titel => 'Geen beloftes die je niet waarmaakt',
      tekst => 'Er wordt geen goedkeuring gesuggereerd en geen maandbedrag genoemd dat later niet blijkt te kloppen.' },
    { titel => 'Je ziet hoe vaak het speelt',
      tekst => 'Hoeveel aanvragen om financiering vragen, is bruikbaar om te weten welke wagens je hoe presenteert.' },
  ],

  systeem => {
    tekst => 'Van alle werkstromen is dit de voorzichtigste. Het doel is niet antwoorden maar doorgeleiden, zonder dat de koper het gevoel krijgt dat hij wordt afgewimpeld.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Dat de vraag over financiering gaat, en over welke wagen.'],
      ['handelen',  'Handelen',  'Uitleggen, ophalen, en overdragen aan een verkoper.'],
    ],
    buren => [
      ['inruil',          'Levert de wagen aan die deel van de financiering wordt.'],
      ['proefrit',        'Combineert de berekening met een rit in dezelfde afspraak.'],
      ['nieuwe-aanvraag', 'Is meestal het gesprek waar deze vraag in opduikt.'],
    ],
  },

  grenzen => [
    'Het berekent geen maandbedrag dat jij niet hebt vastgelegd.',
    'Het doet geen uitspraak over goedkeuring of kredietwaardigheid.',
    'Het vraagt geen financiële gegevens uit.',
    'Het bemiddelt niet en sluit niets af.',
  ],

  cta => 'De vraag die je niet wil laten liggen.',
},

# ── 06 ─────────────────────────────────────────────────────────────────────
{
  slug => 'gemiste-aanvraag',
  nr   => '06',
  naam => 'Opvolging',
  h1   => 'Het gesprek stopt niet <span class="highlight">als de koper stopt met typen.</span>',
  lede => '"Ik denk er nog even over na" is geen nee. Het is het moment waarop bijna elk autobedrijf ophoudt, omdat opvolgen aan iemands geheugen hangt en dat geheugen andere dingen te doen heeft.',

  probleem => {
    titel => 'Opvolgen is werk dat nooit dringend genoeg wordt.',
    tekst => [
      'Een koper vraagt naar een wagen, krijgt antwoord, zegt dat hij erover nadenkt en verdwijnt. Er is geen afwijzing, er is alleen stilte. En stilte staat op niemands takenlijst.',
      'Drie dagen later weet niemand meer wie het was, welke wagen het betrof en wat er is afgesproken. De aanvraag bestaat nog in een mailbox, maar leeft niet meer.',
      'Wie op dag drie een kort bericht stuurt met de juiste wagen erbij, haalt een deel van die kopers terug. Dat gebeurt bijna nergens, en dat is precies waarom het werkt.',
    ],
    gevolgen => [
      'Een koper die twijfelde, koopt elders zonder dat je het merkt.',
      'Het werk dat in het eerste gesprek zat, levert niets op.',
      'Niemand weet welke aanvragen nog open staan en welke dood zijn.',
    ],
  },

  werkstroom_sub => 'Drie contactmomenten, in jouw toon, en daarna duidelijkheid.',
  stappen => [
    { kop => 'Stilte wordt opgemerkt',
      tekst => 'Een gesprek zonder vervolg krijgt een status en een datum. Zo staat het niet meer in een mailbox maar op een lijst.' },
    { kop => 'Na twee dagen: iets nuttigs',
      tekst => 'Geen "heb je al nagedacht", maar iets dat hem verder helpt. De wagen staat er nog, of er zijn extra foto’s.' },
    { kop => 'Na een week: een moment',
      tekst => 'Een concreet voorstel om te komen kijken of rijden. Ja wordt daarmee makkelijker dan nog een keer uitstellen.' },
    { kop => 'Na twee weken: netjes afsluiten',
      tekst => 'Een laatste bericht dat hij altijd kan reageren, en dat de wagen ondertussen verkocht kan zijn. Daarna stopt het.' },
    { kop => 'De wagen bepaalt de toon',
      tekst => 'Is de wagen inmiddels verkocht, dan wordt dat gezegd, met een alternatief uit je voorraad erbij.' },
    { kop => 'Elke aanvraag krijgt een afloop',
      tekst => 'Afspraak, afgehaakt of verlopen. Geen lijst meer met dingen waarvan niemand weet of ze nog leven.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · drie dagen na het eerste gesprek',
    regels => [
      ['Helvaro', 'Dag Thomas, de X5 waar je naar vroeg staat er nog. Ik heb er een paar extra foto’s van het interieur bij gezet.'],
      ['Koper',   'Bedankt. Ik twijfel nog tussen hem en een Q7.'],
      ['Helvaro', 'Begrijpelijk. De X5 heeft 82.000 km en volledige historiek. Wil je hem zaterdag eens van dichtbij zien? Dan kun je beter vergelijken.'],
      ['Koper',   'Zaterdag kan.'],
      ['Helvaro', 'Zaterdag 14:00 zet ik voor je vast. Tot dan.'],
    ],
    uitkomst => ['Teruggehaald', 'Dag 3 · bezichtiging zaterdag 14:00 · dossier weer actief'],
  },

  opbrengst_titel => 'Kopers die je al had.',
  opbrengst => [
    { titel => 'Het werk is al gedaan',
      tekst => 'Het eerste gesprek is gevoerd, de wagen is bekend. Wat alsnog een afspraak wordt, kost bijna niets extra.' },
    { titel => 'Twijfel is geen afwijzing',
      tekst => 'Tussen "ik denk erover na" en een nee zit ruimte. Die ruimte gebruikt bijna niemand.' },
    { titel => 'Een nee is ook winst',
      tekst => 'Dan weet je dat die wagen weer vrij is voor iemand anders en stop je met erop rekenen.' },
    { titel => 'Niemand hoeft na te bellen',
      tekst => 'Het ongemakkelijkste telefoontje van de week verdwijnt uit het takenlijstje van je verkoper.' },
  ],

  systeem => {
    tekst => 'Deze werkstroom zit vast aan alle andere. Elk gesprek dat stilvalt, waar het ook begon, komt hier terecht.',
    lagen => [
      ['handelen',  'Handelen',  'Drie contactmomenten met de wagen erbij, dan stoppen.'],
      ['begrijpen', 'Begrijpen', 'Welke wagen, wat er al gezegd is, en of die nog beschikbaar is.'],
      ['meten',     'Meten',     'Open, teruggehaald, afgehaakt, verlopen.'],
    ],
    buren => [
      ['nieuwe-aanvraag', 'Levert de gesprekken aan die stil vielen.'],
      ['voertuigadvies',  'Biedt een alternatief wanneer de wagen verkocht is.'],
      ['proefrit',        'Zet de teruggehaalde koper om in een rit.'],
    ],
  },

  grenzen => [
    'Het stopt na drie berichten. Blijven aandringen levert geen afspraken op.',
    'Het benadert niemand die heeft aangegeven geen berichten te willen.',
    'Het geeft geen korting weg om iemand over de streep te trekken.',
    'Het belooft niet dat een wagen beschikbaar blijft.',
  ],

  cta => 'Stilte is geen nee.',
},

# ── 07 ─────────────────────────────────────────────────────────────────────
{
  slug => 'e-mail',
  nr   => '07',
  naam => 'E-mail',
  h1   => 'De serieuze aanvragen <span class="highlight">komen nog altijd per mail.</span>',
  lede => 'Een mail is langer, bevat vaker een inruil en komt vaker van iemand die het meent. En juist die mail zakt weg tussen facturen, nieuwsbrieven en leveranciers.',

  probleem => {
    titel => 'Een goede aanvraag verdwijnt in een gedeelde mailbox.',
    tekst => [
      'In de algemene mailbox van een autobedrijf komt alles binnen: aanvragen, facturen, meldingen van advertentiesites en reclame. Een aanvraag die daar om kwart over acht ’s avonds in valt, ligt de volgende ochtend onder twintig andere berichten.',
      'Er is geen eigenaar. Iedereen denkt dat iemand anders het wel oppakt, en dat is precies wat er niet gebeurt.',
      'Bovendien staat er in zo’n mail vaak meer dan in een chatbericht: welke wagen, wat hij nu rijdt, wanneer hij tijd heeft. Dat is gratis informatie die ongebruikt blijft.',
    ],
    gevolgen => [
      'De beste aanvraag van de week wordt de traagst beantwoorde.',
      'Niemand voelt zich eigenaar, dus blijft hij liggen.',
      'Wat er in de mail staat, wordt nooit in een dossier gezet.',
    ],
  },

  werkstroom_sub => 'Van bericht in een mailbox naar dossier met een volgende stap.',
  stappen => [
    { kop => 'De mail wordt gelezen',
      tekst => 'Aanvragen worden onderscheiden van facturen en reclame. Alleen wat over een wagen gaat, komt in de stroom.' },
    { kop => 'De wagen eruit halen',
      tekst => 'Uit de link, het advertentienummer of de omschrijving. Is het niet eenduidig, dan wordt er teruggevraagd.' },
    { kop => 'De rest eruit halen',
      tekst => 'Inruil, budget, termijn, wanneer hij kan. Wat er in de mail staat, hoeft niemand nog een keer te vragen.' },
    { kop => 'Antwoorden in dezelfde toon',
      tekst => 'Een mail verdient een mail, geen chatbericht. Met de gegevens van de wagen en een concreet voorstel erin.' },
    { kop => 'Een dossier aanmaken',
      tekst => 'Ook als hij later op WhatsApp verdergaat, blijft het hetzelfde dossier met dezelfde wagen.' },
    { kop => 'Opvolgen',
      tekst => 'Blijft het stil, dan gaat het naar de opvolging, net als bij elk ander kanaal.' },
  ],

  gesprek => {
    kanaal => 'E-mail · 20:15',
    regels => [
      ['Koper',   'Goedenavond, ik heb interesse in de BMW X5 die op uw site staat. Is die nog beschikbaar? Ik rijd zelf een Audi A4 uit 2018 die ik eventueel wil inruilen. In het weekend heb ik tijd om langs te komen.'],
      ['Helvaro', 'Goedenavond, de X5 xDrive30d uit 2021 staat inderdaad nog te koop. 82.000 km, automaat, € 48.900, met volledige onderhoudshistoriek. Voor uw Audi A4 kijkt een van onze verkopers graag wat die waard is. Zaterdag kan om 11:00 of 14:00, dan bekijken we beide wagens samen.'],
    ],
    uitkomst => ['Dossier aangemaakt', 'BMW X5 · inruil Audi A4 2018 · voorstel zaterdag'],
  },

  opbrengst_titel => 'Het kanaal met de beste aanvragen.',
  opbrengst => [
    { titel => 'Niets blijft liggen',
      tekst => 'Elke aanvraag krijgt binnen minuten een antwoord, ook die van kwart over acht ’s avonds.' },
    { titel => 'De informatie wordt gebruikt',
      tekst => 'Wat de koper zelf al opschreef, komt in het dossier in plaats van in een mailbox.' },
    { titel => 'Eén dossier over alle kanalen',
      tekst => 'Mailt hij vanavond en appt hij morgen, dan is dat dezelfde koper met dezelfde wagen.' },
    { titel => 'Je algemene mailbox wordt weer leesbaar',
      tekst => 'Aanvragen gaan naar de stroom, de rest blijft gewoon mail.' },
  ],

  systeem => {
    tekst => 'E-mail is geen tweederangs kanaal maar de plek waar de uitgebreidste aanvragen binnenkomen. Het krijgt daarom dezelfde behandeling als de rest.',
    lagen => [
      ['opvangen',  'Opvangen',  'De algemene mailbox als volwaardig kanaal.'],
      ['begrijpen', 'Begrijpen', 'Welke wagen, welke inruil, welke termijn.'],
      ['handelen',  'Handelen',  'Antwoorden per mail en een moment voorstellen.'],
    ],
    buren => [
      ['inruil',           'Pakt de inruil op die vaak in de mail genoemd wordt.'],
      ['whatsapp',         'Neemt het gesprek over wanneer de koper daarop overstapt.'],
      ['gemiste-aanvraag', 'Volgt op wanneer er geen antwoord komt.'],
    ],
  },

  grenzen => [
    'Het beantwoordt geen mail die niet over een wagen gaat.',
    'Het verzint geen gegevens die niet in je voorraad staan.',
    'Het noemt geen inruilbedrag.',
    'Een boze of juridische mail gaat meteen naar een mens.',
  ],

  cta => 'De mail van gisteravond staat er nog.',
},

# ── 08 ─────────────────────────────────────────────────────────────────────
{
  slug => 'whatsapp',
  nr   => '08',
  naam => 'WhatsApp',
  h1   => 'Op WhatsApp antwoorden mensen <span class="highlight">wel.</span>',
  lede => 'Een koper belt niet terug en leest zijn mail niet, maar op een appje reageert hij binnen het uur. Daarom is dit het kanaal waar gesprekken doorlopen en waar afspraken vastgezet worden.',

  probleem => {
    titel => 'Het snelste kanaal is het slechtst georganiseerde.',
    tekst => [
      'WhatsApp zit meestal op de telefoon van één verkoper. Is hij vrij, dan ligt het gesprek stil. Gaat hij weg, dan gaat het klantcontact mee.',
      'Er is geen dossier, geen overzicht en geen overdracht. Wat er is afgesproken staat in een chat waar niemand anders bij kan.',
      'Tegelijk is het het kanaal waarop kopers het snelst reageren. Dat maakt het te belangrijk om aan één telefoon te hangen.',
    ],
    gevolgen => [
      'Klantcontact dat op een privételefoon staat, is geen bedrijfsbezit.',
      'Een collega kan niet overnemen, want hij ziet het gesprek niet.',
      'Afspraken staan in een chat in plaats van in een agenda.',
    ],
  },

  werkstroom_sub => 'Hetzelfde systeem, op het kanaal waar je koper toch al zit.',
  stappen => [
    { kop => 'Eén nummer voor het bedrijf',
      tekst => 'Niet de telefoon van een verkoper, maar een nummer van het bedrijf waar iedereen bij kan en waar alles bewaard blijft.' },
    { kop => 'Het gesprek begint met de wagen',
      tekst => 'Komt hij van een advertentie, dan is de wagen meteen bekend. Zo niet, dan wordt er doorgevraagd.' },
    { kop => 'Antwoorden en doorvragen',
      tekst => 'Beschikbaarheid, gegevens, en de vragen die daarna komen. In dezelfde toon als je bedrijf zelf zou gebruiken.' },
    { kop => 'Foto’s beide kanten op',
      tekst => 'Extra beelden van de wagen naar de koper, foto’s van zijn inruil naar jou. Dat gaat op WhatsApp vanzelf.' },
    { kop => 'De afspraak vastzetten',
      tekst => 'Met een bevestiging en een herinnering de dag ervoor, in dezelfde chat.' },
    { kop => 'Je verkoper leest mee',
      tekst => 'Hij ziet het gesprek lopen en stapt erin wanneer het nodig is. Daarna kan hij het weer laten lopen.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · vanaf een advertentie',
    regels => [
      ['Koper',   'Hoi, ik zag de Golf GTI staan. Nog beschikbaar?'],
      ['Helvaro', 'Ja, de Golf GTI uit 2022 met 41.000 km staat er nog, € 34.500.'],
      ['Koper',   'Heeft hij schade gehad?'],
      ['Helvaro', 'In onze gegevens staat geen schadeverleden. De volledige historiek ligt bij de wagen, die kun je ter plaatse inkijken.'],
      ['Koper',   'En kan ik er zaterdag mee rijden?'],
      ['Helvaro', 'Zaterdag kan om 10:00 of om 13:30. Neem je rijbewijs mee.'],
      ['Koper',   '10:00 graag 👍'],
    ],
    uitkomst => ['Proefrit vastgezet', 'Zaterdag 10:00 · Golf GTI · bevestiging verstuurd'],
  },

  opbrengst_titel => 'Het kanaal waarop ze wel antwoorden.',
  opbrengst => [
    { titel => 'Kopers reageren sneller',
      tekst => 'Een appje wordt gelezen. Een voicemail en een mail vaak niet.' },
    { titel => 'Het gesprek blijft van het bedrijf',
      tekst => 'Niet op de telefoon van een verkoper, maar in een dossier waar je collega’s bij kunnen.' },
    { titel => 'Overdragen kost niets',
      tekst => 'Wie overneemt, ziet het hele gesprek. De koper merkt de wissel niet.' },
    { titel => 'Foto’s zijn geen gedoe',
      tekst => 'Beelden van de wagen of van zijn inruil gaan heen en weer zonder dat iemand een mailadres hoeft te vragen.' },
  ],

  systeem => {
    tekst => 'WhatsApp is geen los product maar hetzelfde systeem op een ander kanaal. Dezelfde koper, dezelfde wagen, hetzelfde dossier.',
    lagen => [
      ['opvangen',  'Opvangen',  'Eén bedrijfsnummer in plaats van een privételefoon.'],
      ['handelen',  'Handelen',  'Antwoorden, doorvragen, afspraak vastzetten.'],
      ['koppelen',  'Koppelen',  'De afspraak komt in de agenda van je team.'],
      ['meten',     'Meten',     'Hoeveel gesprekken, hoeveel afspraken, hoeveel overgenomen.'],
    ],
    buren => [
      ['nieuwe-aanvraag',  'Begint vaak op de website en loopt hier door.'],
      ['inruil',           'Krijgt de foto’s die op dit kanaal het makkelijkst binnenkomen.'],
      ['gemiste-aanvraag', 'Stuurt het opvolgbericht op hetzelfde kanaal.'],
    ],
  },

  grenzen => [
    'Het stuurt geen berichten naar mensen die zich niet zelf gemeld hebben.',
    'Het gebruikt WhatsApp niet voor reclame aan je hele bestand.',
    'Het verzint geen voertuiggegevens, ook niet als de koper aandringt.',
    'Een gesprek dat uit de hand loopt, gaat meteen naar een mens.',
  ],

  cta => 'Daar waar je koper toch al zit.',
},
];
