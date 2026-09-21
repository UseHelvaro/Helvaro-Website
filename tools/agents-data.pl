# ============================================================================
# agents-data.pl — de inhoud van de tien agentpagina's
# ----------------------------------------------------------------------------
# Alleen tekst. De opbouw van de pagina staat in tools/build-agents.pl.
# Pas hier iets aan en draai daarna:
#
#   perl tools/build-agents.pl
#
# Huisstijl: korte spanningsparen, geen uitroeptekens, geen gedachtestreepjes
# in zinnen, en nooit "de AI". Het zijn agents met een taak.
# ============================================================================
use strict;
use utf8;
use warnings;

[
# ── 01 ─────────────────────────────────────────────────────────────────────
{
  slug => 'apk-herinnering-agent',
  nr   => '06',
  naam => 'APK-herinnering',
  h1   => 'De APK verloopt over zes weken. <span class="highlight">Wie belt er eerst?</span>',
  lede => 'Je weet precies welke auto\'s deze maand aan de beurt zijn. Die lijst staat in je systeem en niemand heeft tijd om hem af te bellen. De klant weet het zelf niet meer en boekt bij de garage die hem als eerste een bericht stuurt.',

  probleem => {
    titel => 'Een lijst die iedereen heeft en niemand gebruikt.',
    tekst => [
      'Elk erkend bedrijf heeft de vervaldatums van zijn klanten. Het is de meest voorspelbare omzet in de hele werkplaats: je weet maanden vooruit wie er moet komen. En juist die omzet laat bijna iedereen liggen, omdat afbellen werk is dat nooit dringend genoeg wordt.',
      'Wat er meestal gebeurt: er gaat een brief of een standaardmail uit met "uw APK verloopt binnenkort, neem contact op". Dat legt het werk terug bij de klant. Hij leest het in de auto, denkt eraan het te doen, en denkt er daarna niet meer aan.',
      'De garage die wel belt, wint. Niet omdat hij beter is, maar omdat hij eerder was.',
    ],
    gevolgen => [
      'Een keuring die elders gebeurt, neemt de reparaties die eruit komen mee.',
      'Een klant die een jaar wegblijft, komt het jaar daarna vaak ook niet.',
      'De rustige weken blijven rustig terwijl de lijst gewoon klaarligt.',
    ],
  },

  werkstroom_sub => 'Van vervaldatum naar vastgezette afspraak, zonder dat iemand een lijst hoeft af te bellen.',
  stappen => [
    { kop => 'De lijst wordt elke week bekeken',
      tekst => 'Alle auto\'s waarvan de APK binnen zes weken verloopt, komen in beeld. Je bepaalt zelf hoeveel weken vooruit en hoeveel berichten er per dag uitgaan, zodat je planning het aankan.' },
    { kop => 'Een bericht met een datum erin',
      tekst => 'Geen "neem contact op", maar "donderdag de 13e om 08:30 is vrij". Het verschil tussen die twee zinnen is het verschil tussen een herinnering en een afspraak.' },
    { kop => 'Vragen worden beantwoord',
      tekst => 'Wat kost het, hoelang duurt het, kan ik wachten, moet ik iets meenemen, wat als hij wordt afgekeurd. Dat zijn steeds dezelfde vijf vragen en ze krijgen meteen antwoord.' },
    { kop => 'De afspraak wordt vastgezet',
      tekst => 'Past het voorgestelde moment niet, dan komen er alternatieven. De afspraak gaat in je planning met de juiste tijdsduur voor een keuring.' },
    { kop => 'Stilte krijgt nog twee kansen',
      tekst => 'Wie niet reageert, hoort nog een keer iets een week later en nog een keer vlak voor de vervaldatum. Daarna stopt het, want doorgaan is irritant en dat kost je de klant helemaal.' },
    { kop => 'Wat je erover wil weten, staat er',
      tekst => 'Hoeveel benaderd, hoeveel gereageerd, hoeveel geboekt. Per week, exporteerbaar, zodat je ziet of het iets doet.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · zes weken voor de vervaldatum',
    regels => [
      ['Helvaro', 'Dag Marloes, de APK van je Polo (82-ABC-3) loopt af op 14 november. Donderdag de 13e om 08:30 hebben we plek. Zal ik die voor je vastzetten?'],
      ['Klant',   'Hoeveel kost een keuring bij jullie?'],
      ['Helvaro', 'De APK is € 49,50 inclusief afmelding bij de RDW. Komt er iets uit dat gerepareerd moet worden, dan bellen we je eerst met een prijs. Nooit zomaar doorwerken.'],
      ['Klant',   'Prima. Kan het ook op vrijdag?'],
      ['Helvaro', 'Vrijdag de 14e kan om 09:15 of om 14:00. Welke past?'],
      ['Klant',   '09:15'],
    ],
    uitkomst => ['Vastgezet', 'Vrijdag 14 november · 09:15 · APK · 1 uur'],
  },

  opbrengst_titel => 'Voorspelbare omzet die je nu laat liggen.',
  opbrengst => [
    { titel => 'De keuring is het begin, niet het eind',
      tekst => 'Een APK op zichzelf is weinig geld. Wat eruit komt aan remmen, banden en schokdempers is dat wel, en dat gebeurt alleen bij de garage waar de auto staat.' },
    { titel => 'Rustige weken vullen zich',
      tekst => 'Omdat je zelf bepaalt hoeveel berichten er per dag uitgaan, kun je de lijst inzetten om gaten in je planning te vullen in plaats van drukte te verergeren.' },
    { titel => 'Een klant blijft nog een jaar',
      tekst => 'Wie zijn keuring bij jou doet, komt daarna terug voor onderhoud. Wie hem elders doet, is meestal ook zijn volgende beurt kwijt.' },
    { titel => 'Niemand hoeft een lijst af te bellen',
      tekst => 'Dat is werk waar je balie nooit aan toekomt en dat toch elke maand terugkomt. Het is precies het soort werk dat zich laat overnemen.' },
  ],

  systeem => {
    tekst => 'Een losse herinneringsdienst stuurt berichten en weet daarna van niets. Deze agent weet wat de klant antwoordde, wat er werd afgesproken en wat er daarna in de werkplaats gebeurde.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Kenteken, voertuig en de vervaldatum die de aanleiding is.'],
      ['handelen',  'Handelen',  'Voorstellen, antwoorden op vragen en de afspraak vastzetten.'],
      ['koppelen',  'Koppelen',  'De keuring komt in de planning met de juiste tijdsduur.'],
      ['meten',     'Meten',     'Benaderd, gereageerd, geboekt. Per week te volgen.'],
    ],
    buren => [
      ['werkplaats-inplan-agent', 'Zorgt dat het tijdslot klopt en niet over een andere klus heen valt.'],
      ['no-show-agent',           'Bevestigt en herinnert, zodat de geboekte keuring ook komt opdagen.'],
      ['onderhoudsbeurt-herinnering-agent', 'Pakt dezelfde klant op wanneer de beurt aan de beurt is.'],
    ],
  },

  grenzen => [
    'Hij keurt niets goed of af. Hij plant alleen de afspraak.',
    'Hij noemt alleen prijzen die jij hebt vastgelegd. Voor reparaties na de keuring belt een mens.',
    'Hij meldt niets af bij de RDW. Dat blijft bij jou.',
    'Hij stopt na drie berichten. Blijven aandringen levert geen afspraken op, alleen ergernis.',
  ],

  cta => 'Je lijst ligt er al. Zet hem aan het werk.',
},

# ── 02 ─────────────────────────────────────────────────────────────────────
{
  slug => 'werkplaats-inplan-agent',
  nr   => '02',
  naam => 'Werkplaats inplannen',
  h1   => 'Een afspraak die niet in je planning past, <span class="highlight">is geen hulp.</span>',
  lede => 'De meeste boekingssystemen zetten een klant in een vakje van een uur, ongeacht of het een bandenwissel is of een distributieriem. Daarna mag je werkplaatschef het rechtzetten. Deze agent weet hoelang een klus duurt voor hij iets belooft.',

  probleem => {
    titel => 'Online boeken werkt pas als de duur klopt.',
    tekst => [
      'Een keuring is anderhalf uur. Een grote beurt is een halve dag. Een koppeling is anderhalve dag en je hebt er een brug voor nodig die niet ondertussen voor iets anders nodig is. Een agenda met vakjes van een uur kent dat verschil niet.',
      'Het gevolg is bekend. De klant boekt iets online, de werkplaats ziet het, en iemand moet terugbellen om het te verzetten. Dan had je het net zo goed meteen telefonisch kunnen doen, en heb je bovendien een klant die zich voor niets verheugd had.',
      'Een afspraak is pas iets waard als je monteur er die ochtend op kan rekenen.',
    ],
    gevolgen => [
      'Terugbellen om te verzetten kost meer tijd dan de afspraak zelf inplannen.',
      'Een klus die uitloopt, duwt de rest van de dag voor zich uit.',
      'Je werkplaatschef gaat het systeem wantrouwen en plant weer met de hand.',
    ],
  },

  werkstroom_sub => 'Eerst uitzoeken wat het is, dan pas een moment noemen.',
  stappen => [
    { kop => 'Eerst de klus bepalen',
      tekst => 'Waar komt de auto voor. Keuring, beurt, reparatie, banden, schade of iets dat eerst bekeken moet worden. Zolang dat niet duidelijk is, wordt er geen tijdslot genoemd.' },
    { kop => 'De juiste duur erbij',
      tekst => 'Je legt zelf vast hoelang elk soort klus bij jou duurt. De agent gebruikt die duur, niet een standaard uur dat toevallig in een agenda past.' },
    { kop => 'Kijken wat er werkelijk vrij is',
      tekst => 'Een tijdslot wordt alleen aangeboden als er ruimte voor de hele klus is en de benodigde plek vrij is. Half een brug boeken is niet boeken.' },
    { kop => 'Wachten of brengen',
      tekst => 'Wie wacht heeft een ochtendslot nodig en een klus van hooguit twee uur. Wie brengt kan de hele dag. Die vraag komt vooraf, niet aan de balie.' },
    { kop => 'Vastzetten en bevestigen',
      tekst => 'De afspraak gaat in de planning, de klant krijgt een bevestiging met wat hij moet meenemen en hoelang het duurt.' },
    { kop => 'Wat niet past, gaat naar een mens',
      tekst => 'Een onbekende klacht, een oldtimer, iets waar eerst naar gekeken moet worden. Dat gaat door naar je werkplaatschef, met het gesprek erbij.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · binnenkomende vraag',
    regels => [
      ['Klant',   'Ik hoor een piep bij het remmen, kan ik langskomen?'],
      ['Helvaro', 'Dat kijken we na. Wat is het kenteken?'],
      ['Klant',   '82-ABC-3'],
      ['Helvaro', 'Volkswagen Golf uit 2019. Voor remmen nakijken rekenen we een uur, en als er geschuurd of vervangen moet worden komt daar tijd bij. Wil je wachten of brengen?'],
      ['Klant',   'Liefst wachten.'],
      ['Helvaro', 'Dan plan ik een ochtend. Dinsdag 08:00 of woensdag 08:30, dan is de kans het grootst dat je dezelfde ochtend weer weg kunt.'],
      ['Klant',   'Dinsdag.'],
    ],
    uitkomst => ['Vastgezet', 'Dinsdag · 08:00 · remmen nakijken · 1 uur · wacht'],
  },

  opbrengst_titel => 'Een planning waar je monteur op kan bouwen.',
  opbrengst => [
    { titel => 'Minder verzetten',
      tekst => 'Omdat de duur vooraf klopt, hoeft er achteraf veel minder gebeld te worden om iets te verschuiven.' },
    { titel => 'Wachters op de juiste plek',
      tekst => 'Wie wacht, krijgt een ochtendslot en een korte klus. Dat voorkomt een wachtruimte vol mensen die tot drie uur blijven zitten.' },
    { titel => 'Ook buiten openingsuren boeken',
      tekst => 'Een klant die om tien uur ’s avonds iets wil regelen, kan dat. De planning die de volgende ochtend klaarstaat, klopt.' },
    { titel => 'Je balie doet het niet meer',
      tekst => 'Inplannen is het werk waar telkens iets tussen komt. Het is ook het werk dat zich het best laat vastleggen in regels.' },
  ],

  systeem => {
    tekst => 'Deze agent is de plek waar bijna alle andere werkstromen uitkomen. Een APK-herinnering, een gemiste oproep en een offerte die ja wordt, eindigen allemaal in een afspraak.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Welke klus het is, en hoelang die bij jou duurt.'],
      ['handelen',  'Handelen',  'Een moment voorstellen, vastzetten en bevestigen.'],
      ['koppelen',  'Koppelen',  'De afspraak schrijft naar de planning waar je team in werkt.'],
    ],
    buren => [
      ['apk-herinnering-agent',   'Levert de keuringen aan die hier een tijdslot krijgen.'],
      ['gemiste-gesprekken-agent', 'Brengt bellers terug die anders weg waren.'],
      ['leenauto-agent',          'Regelt de leenauto die bij een langere klus hoort.'],
    ],
  },

  grenzen => [
    'Hij stelt geen diagnose. Bij een onbekende klacht plant hij tijd om te kijken, geen reparatie.',
    'Hij verschuift geen bestaande afspraken om ruimte te maken.',
    'Hij boekt niets buiten de grenzen die je zelf hebt gezet, ook niet als de klant aandringt.',
    'Zonder koppeling met je planning werkt hij op de agenda die je hem geeft, en niet op een pakket dat nog niet gekoppeld is.',
  ],

  cta => 'Eerst de klus. Dan pas een tijdslot.',
},

# ── 03 ─────────────────────────────────────────────────────────────────────
{
  slug => 'gemiste-gesprekken-agent',
  nr   => '01',
  naam => 'Gemiste gesprekken',
  h1   => 'Je weet niet hoeveel klanten je misloopt. <span class="highlight">Dat is het probleem.</span>',
  lede => 'Een onbeantwoorde oproep laat geen spoor na. Er komt geen melding, er staat niets in een systeem en niemand voelt zich verantwoordelijk. Het is het enige gat in je bedrijf waarvan je de omvang niet kent, en meestal het eerste dat we dichtmaken.',

  probleem => {
    titel => 'De stilste kostenpost die je hebt.',
    tekst => [
      'Om kwart over negen rinkelt de telefoon terwijl je balie iemand helpt en de tweede lijn ook overgaat. De beller wacht, hangt op en belt de volgende garage. Bij jou is er niets gebeurd: geen gemiste oproep in beeld, geen naam, geen nummer, geen herinnering.',
      'Bij een half uur pauze, een drukke ochtend en een zaterdag opgeteld gaat het in de meeste werkplaatsen om tien tot twintig oproepen per week. Vraag het je balie en je krijgt een schatting. Vraag het je telefooncentrale en je krijgt meestal niets.',
      'Wat je niet ziet, kun je niet oplossen. Daarom begint dit met zichtbaar maken.',
    ],
    gevolgen => [
      'Een beller die niet doorkomt, belt zelden een tweede keer.',
      'Je weet niet of het er vijf of vijftig per week zijn.',
      'Je balie voelt zich schuldig over iets waar ze niets aan kan doen.',
    ],
  },

  werkstroom_sub => 'Van een oproep die niemand opnam naar een gesprek dat wel doorloopt.',
  stappen => [
    { kop => 'De gemiste oproep wordt opgemerkt',
      tekst => 'Een oproep die niet werd opgenomen, die te lang in de wacht stond of die buiten openingsuren binnenkwam, wordt vastgelegd met tijdstip en nummer.' },
    { kop => 'Binnen een minuut een bericht',
      tekst => 'Geen uur later en niet de volgende ochtend. Binnen een minuut krijgt de beller een bericht: we zagen dat je belde, waar kunnen we mee helpen.' },
    { kop => 'Het gesprek loopt door op WhatsApp',
      tekst => 'De meeste mensen antwoorden daar sneller dan dat ze terugbellen. Ze kunnen het doen terwijl ze op de bus staan of tussen twee klussen door.' },
    { kop => 'De vraag wordt uitgezocht',
      tekst => 'Waar komt het voor, welke auto, hoe dringend. Dezelfde vragen die je balie zou stellen, met het kenteken als startpunt.' },
    { kop => 'Een afspraak of een terugbelmoment',
      tekst => 'Kan het ingepland worden, dan gebeurt dat meteen. Moet er een mens aan te pas komen, dan staat er een terugbelmoment met de reden erbij.' },
    { kop => 'De teller loopt',
      tekst => 'Hoeveel oproepen er gemist werden, hoeveel er antwoordden en hoeveel er een afspraak werden. Voor het eerst een getal in plaats van een gevoel.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · één minuut na een onbeantwoorde oproep',
    regels => [
      ['Helvaro', 'Dag, we zagen dat je net belde naar Garage Verstraeten en dat we je niet te pakken kregen. Waar kunnen we mee helpen?'],
      ['Klant',   'Mijn airco blaast niet koud meer.'],
      ['Helvaro', 'Vervelend. Wat is het kenteken, dan kijk ik wat erbij hoort.'],
      ['Klant',   '82-ABC-3'],
      ['Helvaro', 'Volkswagen Golf uit 2019. We beginnen met een aircocontrole, dat is een half uur. Blijkt er te weinig koudemiddel in te zitten, dan vullen we bij en dat kost € 89. Donderdag om 10:00 is vrij.'],
      ['Klant',   'Doen.'],
    ],
    uitkomst => ['Teruggehaald', 'Donderdag · 10:00 · aircocontrole · 30 min'],
  },

  opbrengst_titel => 'Het gat dat je meteen kunt meten.',
  opbrengst => [
    { titel => 'Een getal waar je er geen had',
      tekst => 'Na twee weken weet je hoeveel oproepen er werkelijk niet werden opgenomen. Dat cijfer alleen al is het gesprek waard.' },
    { titel => 'Werk dat anders bij de buren lag',
      tekst => 'Een beller die niet doorkomt is geen uitgestelde klant, hij is een klant van iemand anders. Dit is het snelst terug te winnen deel.' },
    { titel => 'Avonden en zaterdagen tellen mee',
      tekst => 'Ruim een derde van de week ligt buiten je openingsuren. Nu gebeurt daar iets in plaats van niets.' },
    { titel => 'Rust aan de balie',
      tekst => 'Je balie hoeft niet meer met een half oog naar de tweede lijn te kijken terwijl ze een klant helpt.' },
  ],

  systeem => {
    tekst => 'Dit is de werkstroom waarmee we meestal beginnen, juist omdat hij zichtbaar maakt hoe groot het probleem is. Daarna is het gesprek over de rest een stuk korter.',
    lagen => [
      ['opvangen',  'Opvangen',  'De oproep die niemand aannam, wordt toch een gesprek.'],
      ['begrijpen', 'Begrijpen', 'Kenteken en soort aanvraag, voor er een afspraak komt.'],
      ['handelen',  'Handelen',  'Inplannen of doorgeven met een terugbelmoment.'],
      ['meten',     'Meten',     'Gemist, beantwoord, geboekt. Het cijfer dat er niet was.'],
    ],
    buren => [
      ['werkplaats-inplan-agent', 'Zet de teruggehaalde klant in het juiste tijdslot.'],
      ['leenauto-agent',          'Beantwoordt de leenautovraag die vaak meteen volgt.'],
      ['onderdelen-navraag-agent', 'Zoekt uit of het onderdeel er is voor er een datum wordt beloofd.'],
    ],
  },

  grenzen => [
    'Hij belt niet terug. Het gesprek loopt door via bericht, tenzij jij terugbelt.',
    'Hij benadert geen nummers die niet zelf hebben gebeld.',
    'Bij een onbekend of afgeschermd nummer kan hij niets sturen.',
    'Een boze beller gaat meteen naar een mens, niet naar een tweede bericht.',
  ],

  cta => 'Twee weken meten. Dan weet je hoe groot het is.',
},

# ── 04 ─────────────────────────────────────────────────────────────────────
{
  slug => 'offerte-opvolg-agent',
  nr   => '08',
  naam => 'Offerte-opvolging',
  h1   => 'De prijs is berekend en verstuurd. <span class="highlight">Daarna gebeurt er niets meer.</span>',
  lede => 'Het dure werk is al gedaan: uitzoeken, onderdelen opvragen, een bedrag opstellen. Wat ontbreekt is het laatste duwtje, en dat is precies waar de marge zit. Een offerte zonder opvolging is een investering die je weggooit.',

  probleem => {
    titel => 'Geen ja, geen nee, alleen stilte.',
    tekst => [
      'Een klant krijgt een prijs voor een distributieriem of een setje schokdempers en zegt dat hij erover nadenkt. Dat is geen afwijzing, dat is een klant die het even niet wil beslissen. Als niemand er daarna nog op terugkomt, wordt die aarzeling vanzelf een nee.',
      'Nabellen gebeurt bijna nooit. Niet uit onwil, maar omdat er altijd iets dringenders is dan iemand die niets van zich laat horen. En omdat het ongemakkelijk voelt om te bellen over geld.',
      'Een nee is trouwens ook waardevol. Dan weet je dat je die auto niet hoeft in te plannen en stopt het naijlen.',
    ],
    gevolgen => [
      'Het uitzoekwerk is al betaald, maar levert niets op.',
      'De klant rijdt door met een probleem en komt met pech terug bij iemand anders.',
      'Niemand weet welke offertes nog openstaan en welke dood zijn.',
    ],
  },

  werkstroom_sub => 'Drie contactmomenten, in jouw toon, en daarna duidelijkheid.',
  stappen => [
    { kop => 'De offerte komt in beeld',
      tekst => 'Zodra er een prijs de deur uitgaat, staat die op de lijst met een datum. Je ziet in één scherm wat er openstaat en hoe lang al.' },
    { kop => 'Na twee dagen: is het duidelijk',
      tekst => 'Geen verkooppraatje, maar de vraag of de offerte aangekomen is en of er iets onduidelijk was. Dat is meestal het echte bezwaar.' },
    { kop => 'Vragen krijgen antwoord',
      tekst => 'Waarom is het zo duur, moet het nu meteen, kan het in delen, hoelang kan ik nog doorrijden. Die vragen zijn de reden dat het stil bleef.' },
    { kop => 'Na een week: een datum aanbieden',
      tekst => 'Niet nog eens vragen of hij erover nagedacht heeft, maar een concreet tijdslot noemen. Ja wordt daarmee makkelijker dan nee.' },
    { kop => 'Na twee weken: netjes afsluiten',
      tekst => 'Een laatste bericht waarin staat dat de offerte binnenkort vervalt en dat hij altijd nog kan reageren. Daarna stopt het echt.' },
    { kop => 'Elke offerte krijgt een status',
      tekst => 'Geboekt, afgewezen of verlopen. Geen lijst meer met dingen waarvan niemand weet of ze nog leven.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · zeven dagen na de offerte',
    regels => [
      ['Helvaro', 'Dag Peter, vorige week stuurden we je de prijs voor de distributieriem van je Passat: € 780 inclusief waterpomp en arbeid. Zal ik er een dag voor vrijhouden?'],
      ['Klant',   'Het is best veel geld. Kan het nog even wachten?'],
      ['Helvaro', 'Bij 168.000 km zit je op het interval waarop hij vervangen hoort te worden. Doorrijden kan, maar als de riem breekt is de motorschade een veelvoud van dit bedrag. We plannen het liever in dan dat je het risico loopt.'],
      ['Klant',   'En kan ik ondertussen een auto lenen?'],
      ['Helvaro', 'Ja, we hebben een leenauto beschikbaar, die reserveer ik erbij. Donderdag de 21e kunnen we ermee beginnen.'],
      ['Klant',   'Oké, doe maar.'],
    ],
    uitkomst => ['Offerte geaccepteerd', 'Donderdag 21 · distributieriem · € 780 · leenauto erbij'],
  },

  opbrengst_titel => 'De marge die al in huis was.',
  opbrengst => [
    { titel => 'Werk waar de kosten al in zitten',
      tekst => 'Het uitzoeken en calculeren is gedaan en betaald. Elke offerte die alsnog ja wordt, is bijna volledig marge.' },
    { titel => 'Bezwaren komen boven water',
      tekst => 'Te duur is zelden het echte bezwaar. Meestal is het onzekerheid over urgentie of over vervoer. Beide zijn te beantwoorden.' },
    { titel => 'Een nee is ook winst',
      tekst => 'Dan weet je dat die auto niet meer terugkomt en stop je met erop rekenen in je planning.' },
    { titel => 'Niemand hoeft over geld te bellen',
      tekst => 'Het ongemakkelijkste telefoontje van de week verdwijnt uit het takenlijstje van je balie.' },
  ],

  systeem => {
    tekst => 'Een opvolgmail uit een pakket weet niet wat er in de werkplaats gebeurde. Deze agent kent de auto, de kilometerstand en het gesprek waaruit de offerte voortkwam.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Welke auto, welke klus, welk bedrag en sinds wanneer.'],
      ['handelen',  'Handelen',  'Drie contactmomenten, vragen beantwoorden, inplannen.'],
      ['koppelen',  'Koppelen',  'Een ja wordt meteen een afspraak in de planning.'],
      ['meten',     'Meten',     'Openstaand, geboekt, afgewezen, verlopen.'],
    ],
    buren => [
      ['werkplaats-inplan-agent', 'Zet de geaccepteerde offerte om in een tijdslot met de juiste duur.'],
      ['leenauto-agent',          'Neemt het bezwaar weg dat de klant zonder vervoer zit.'],
      ['onderdelen-navraag-agent', 'Checkt of het onderdeel leverbaar is voor er een datum wordt beloofd.'],
    ],
  },

  grenzen => [
    'Hij onderhandelt niet over de prijs en geeft geen korting.',
    'Hij past de offerte niet aan. Moet er iets veranderen, dan gaat het naar je balie.',
    'Hij geeft geen technisch advies over of iets kan wachten, alleen wat jij hebt vastgelegd.',
    'Hij stopt na drie berichten, ook als er niets is teruggekomen.',
  ],

  cta => 'Je hebt het rekenwerk al gedaan. Haal het op.',
},

# ── 05 ─────────────────────────────────────────────────────────────────────
{
  slug => 'no-show-agent',
  nr   => '10',
  naam => 'No-shows',
  h1   => 'Een lege brug kost evenveel <span class="highlight">als een volle.</span>',
  lede => 'De afspraak van twee uur komt niet opdagen. Je monteur staat er, de kosten lopen door, en het is te laat om het gat nog te vullen. Vier no-shows per maand is ruim een halve werkdag die je gewoon weggeeft.',

  probleem => {
    titel => 'Je verkoopt tijd, en die kun je niet bewaren.',
    tekst => [
      'Anders dan bij onderdelen kun je een uur werkplaats niet terugleggen in het schap. Een tijdslot dat leeg blijft, is voorgoed weg. En toch is dit de kostenpost die het minst in de gaten wordt gehouden, omdat hij nergens op een factuur verschijnt.',
      'De meeste no-shows zijn geen onwil. Mensen vergeten het, hebben de datum verkeerd onthouden of kunnen die ochtend ineens niet weg van hun werk. Een bericht de dag ervoor lost het merendeel daarvan op.',
      'De tweede helft van de oplossing is het gat vullen. Iemand die volgende week zou komen, wil vaak best eerder.',
    ],
    gevolgen => [
      'Een leeg uur op de brug kost je de volledige uurprijs van die post.',
      'Je monteur zit stil terwijl er klanten op een wachtlijst staan.',
      'Wie niet komt opdagen, boekt daarna zelden zelf opnieuw.',
    ],
  },

  werkstroom_sub => 'Voorkomen wat te voorkomen is, en vullen wat toch vrijkomt.',
  stappen => [
    { kop => 'Bevestigen bij het boeken',
      tekst => 'Meteen na het vastzetten krijgt de klant de afspraak op papier: datum, tijd, wat er gebeurt, hoelang het duurt en wat hij moet meenemen.' },
    { kop => 'Herinneren de dag ervoor',
      tekst => 'Een kort bericht met de vraag of het nog uitkomt. Juist die vraag geeft mensen de ruimte om te zeggen dat het niet lukt, in plaats van gewoon niet te komen.' },
    { kop => 'Verzetten is makkelijker dan wegblijven',
      tekst => 'Wie niet kan, krijgt meteen twee alternatieven. Een verzette afspraak is werk dat behouden blijft, een no-show is werk dat verdwijnt.' },
    { kop => 'Het vrijgekomen slot gaat de lijst op',
      tekst => 'Zodra er iets vrijvalt, wordt het aangeboden aan klanten die verderop in de planning staan of op een wachtlijst stonden.' },
    { kop => 'Wie toch niet komt, krijgt bericht',
      tekst => 'Geen verwijt, maar de vraag of hij een nieuwe datum wil. Dat scheelt een klant die uit schaamte wegblijft.' },
    { kop => 'De cijfers per maand',
      tekst => 'Hoeveel afspraken, hoeveel verzet, hoeveel niet gekomen, hoeveel gaten opnieuw gevuld.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · de dag voor de afspraak',
    regels => [
      ['Helvaro', 'Dag Sanne, morgen om 09:00 staat je Corsa bij ons voor de grote beurt. Komt dat nog steeds uit?'],
      ['Klant',   'Ah, morgen lukt me eigenlijk niet, ik moet werken.'],
      ['Helvaro', 'Geen probleem, dan zoeken we iets anders. Donderdag om 08:00 of zaterdagochtend om 09:30, welke past beter?'],
      ['Klant',   'Zaterdag graag.'],
      ['Helvaro', 'Gedaan. Zaterdag 09:30, grote beurt, ongeveer drie uur. Het slot van morgen bieden we aan iemand anders aan.'],
    ],
    uitkomst => ['Verzet, niet verloren', 'Zaterdag · 09:30 · grote beurt · slot van morgen vrijgegeven'],
  },

  opbrengst_titel => 'Uren die je anders weggeeft.',
  opbrengst => [
    { titel => 'Minder gaten',
      tekst => 'Het merendeel van de no-shows is vergeetachtigheid. Een bericht de dag ervoor haalt daar een flink deel uit.' },
    { titel => 'Verzetten in plaats van verliezen',
      tekst => 'Een klant die niet kan en dat op tijd zegt, is geen verlies. Hij is alleen een andere dag.' },
    { titel => 'Gaten die zichzelf vullen',
      tekst => 'Een vrijgekomen ochtend wordt aangeboden aan wie toch al wachtte. Dat is werk dat je anders pas volgende week had gedaan.' },
    { titel => 'Rust in de planning',
      tekst => 'Je werkplaatschef weet ’s ochtends wat er komt, in plaats van het te ontdekken als het niet komt.' },
  ],

  systeem => {
    tekst => 'Deze agent zit vast aan alles wat er ingepland wordt. Elke afspraak die uit een andere werkstroom komt, loopt hier langs voor de bevestiging en de herinnering.',
    lagen => [
      ['handelen', 'Handelen', 'Bevestigen, herinneren, verzetten en opnieuw aanbieden.'],
      ['koppelen', 'Koppelen', 'Een verzette afspraak verhuist meteen mee in de planning.'],
      ['meten',    'Meten',    'No-shows per maand, en hoeveel gaten er weer gevuld zijn.'],
    ],
    buren => [
      ['werkplaats-inplan-agent',  'Levert de afspraken aan en neemt de verzette datum over.'],
      ['apk-herinnering-agent',    'Zorgt dat geboekte keuringen ook echt komen opdagen.'],
      ['leenauto-agent',           'Lost het vervoersprobleem op dat soms de echte reden is.'],
    ],
  },

  grenzen => [
    'Hij rekent geen kosten door bij niet verschijnen. Dat is jouw beleid, niet het zijne.',
    'Hij belt niet. Bij iemand zonder mobiel nummer werkt dit niet.',
    'Hij blijft niet aandringen bij wie tweemaal niet reageert.',
    'Hij vult een gat alleen met klanten die al een afspraak hadden of zich hebben aangemeld.',
  ],

  cta => 'Tel je lege uren eens een maand lang.',
},

# ── 06 ─────────────────────────────────────────────────────────────────────
{
  slug => 'onderdelen-navraag-agent',
  nr   => '03',
  naam => 'Onderdelen navragen',
  h1   => 'Drie keer terugbellen over één remblok. <span class="highlight">Daar gaat je ochtend.</span>',
  lede => 'De klant vraagt wat het kost en wanneer het kan. Je balie moet eerst de prijs opzoeken, dan de levertijd, dan terugbellen, en dan blijkt de klant in een vergadering te zitten. Dat heen en weer is het werk, niet de reparatie.',

  probleem => {
    titel => 'Wachten op een antwoord dat er al is.',
    tekst => [
      'Bij elke reparatievraag zitten dezelfde drie onbekenden: is het onderdeel er, wat kost het en wanneer kan de auto komen. Zolang één daarvan openstaat, kan er niets ingepland worden.',
      'Het gekke is dat dit bijna altijd bekende informatie is. Het staat in je systeem of het is met één vraag bij je leverancier op te halen. Alleen zit er telkens een mens tussen die er net geen tijd voor heeft.',
      'Ondertussen wacht de klant, en wachten is het moment waarop mensen ergens anders gaan kijken.',
    ],
    gevolgen => [
      'Een reparatie die pas na drie telefoontjes ingepland kan worden, wordt vaak helemaal niet ingepland.',
      'Je belooft een datum en komt er later achter dat het onderdeel er pas volgende week is.',
      'Je balie is een halve ochtend kwijt aan terugbellen.',
    ],
  },

  werkstroom_sub => 'Eerst uitzoeken, dan pas iets beloven.',
  stappen => [
    { kop => 'De vraag wordt scherp gemaakt',
      tekst => 'Welke auto, welk onderdeel, voor of achter, welke uitvoering. Het kenteken beantwoordt het grootste deel daarvan al.' },
    { kop => 'Beschikbaarheid en prijs erbij',
      tekst => 'Uit wat jij hebt vastgelegd of uit de bron die je koppelt. Is het er niet, dan wordt de levertijd opgezocht in plaats van geraden.' },
    { kop => 'De klant hoort het, ook als het slecht nieuws is',
      tekst => 'Een eerlijk "pas dinsdag leverbaar" is beter dan stilte. Dan kan de klant zelf kiezen of hij wacht of niet.' },
    { kop => 'De afspraak volgt de levertijd',
      tekst => 'Er wordt pas een datum geboekt nadat duidelijk is wanneer het onderdeel er is. Zo staat er nooit een auto op de brug zonder onderdeel.' },
    { kop => 'Twijfelgevallen gaan naar je balie',
      tekst => 'Een onduidelijke uitvoering, een onderdeel dat drie varianten heeft, iets dat besteld moet worden zonder retourrecht. Dat beslist een mens.' },
    { kop => 'Niets blijft open staan',
      tekst => 'Elke navraag krijgt een afloop: besteld, afgehaakt of ingepland. Geen briefjes meer op de toonbank.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · binnenkomende vraag',
    regels => [
      ['Klant',   'Wat kost een nieuwe accu voor mijn Golf en hebben jullie er een liggen?'],
      ['Helvaro', 'Dat zoek ik na. Kenteken?'],
      ['Klant',   '82-ABC-3'],
      ['Helvaro', 'Golf 1.0 TSI uit 2019. Daar hoort een 60Ah accu bij, die hebben we op voorraad. € 149 inclusief plaatsen en het oude exemplaar meenemen.'],
      ['Klant',   'En kan dat vandaag nog?'],
      ['Helvaro', 'Vandaag om 16:00 kan, dan sta je er een half uur. Zal ik dat vastzetten?'],
      ['Klant',   'Ja graag.'],
    ],
    uitkomst => ['Op voorraad, vastgezet', 'Vandaag · 16:00 · accu vervangen · 30 min'],
  },

  opbrengst_titel => 'Minder heen en weer, meer geboekt werk.',
  opbrengst => [
    { titel => 'De klant haakt niet af tijdens het wachten',
      tekst => 'Het antwoord komt in hetzelfde gesprek. Er is geen moment waarop hij gaat rondkijken bij een ander.' },
    { titel => 'Geen loze beloftes over datums',
      tekst => 'Een afspraak wordt pas geboekt als de levertijd bekend is. Dat scheelt afzeggingen en teleurstelling.' },
    { titel => 'Je balie belt niet meer terug',
      tekst => 'Het terugbelstapeltje op de toonbank verdwijnt, en daarmee ook het gevoel dat er altijd iets blijft liggen.' },
    { titel => 'Voorraad wordt zichtbaar',
      tekst => 'Wat vaak gevraagd wordt en telkens besteld moet worden, valt op. Dat is nuttige informatie voor je inkoop.' },
  ],

  systeem => {
    tekst => 'Deze agent staat tussen een vraag en een afspraak in. Zonder hem belooft het systeem datums die de werkplaats niet kan waarmaken.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Welk onderdeel bij welke uitvoering hoort.'],
      ['handelen',  'Handelen',  'Opzoeken, terugkoppelen en pas daarna inplannen.'],
      ['koppelen',  'Koppelen',  'Voorraad en prijzen uit de bron die je koppelt.'],
    ],
    buren => [
      ['werkplaats-inplan-agent', 'Krijgt pas een tijdslot te boeken als de levertijd bekend is.'],
      ['offerte-opvolg-agent',    'Gebruikt dezelfde prijzen in de offerte die de deur uitgaat.'],
      ['schade-intake-agent',     'Weet welke onderdelen er bij een schade nodig zijn.'],
    ],
  },

  grenzen => [
    'Hij bestelt niets zelf. Hij zoekt op en koppelt terug, bestellen doet je balie.',
    'Hij kiest niet tussen varianten als de uitvoering onduidelijk is.',
    'Zonder koppeling met je voorraad of leverancier werkt hij alleen met wat jij hebt vastgelegd.',
    'Hij doet geen prijsvergelijking tussen leveranciers.',
  ],

  cta => 'Eerst weten wat er ligt. Dan pas een datum.',
},

# ── 07 ─────────────────────────────────────────────────────────────────────
{
  slug => 'leenauto-agent',
  nr   => '04',
  naam => 'Leenauto',
  h1   => '"En hoe kom ik dan op mijn werk?" <span class="highlight">Dat is de vraag die alles ophoudt.</span>',
  lede => 'Bij elke klus die langer dan een halve dag duurt, komt dezelfde vraag. Zolang die niet beantwoord is, wordt er niets geboekt. En het antwoord is bijna altijd bekend: er staat er wel of niet een vrij.',

  probleem => {
    titel => 'Een kleine vraag die grote klussen tegenhoudt.',
    tekst => [
      'Een distributieriem, een koppeling, een grote beurt. Precies de klussen met de meeste omzet zijn ook de klussen waarbij de klant een dag zonder auto zit. Die drempel is voor veel mensen groter dan het bedrag.',
      'In de praktijk wordt de vraag heen en weer geschoven. De balie moet kijken of er een leenauto vrij is, de klant moet nadenken, en tegen de tijd dat beide rond zijn is de week voorbij.',
      'Wie de vraag meteen beantwoordt, haalt de drempel weg op het moment dat de klant er nog over nadenkt.',
    ],
    gevolgen => [
      'Grote klussen blijven hangen op een vraag die in twee minuten te beantwoorden is.',
      'Een leenauto die wel vrijstond, heeft de hele dag stilgestaan.',
      'Dezelfde auto wordt per ongeluk twee keer toegezegd.',
    ],
  },

  werkstroom_sub => 'De vraag beantwoorden op het moment dat hij gesteld wordt.',
  stappen => [
    { kop => 'De vraag komt vanzelf ter sprake',
      tekst => 'Bij een klus die langer duurt dan een paar uur, wordt de vervoersvraag gesteld voordat de klant hem stelt. Dat scheelt een ronde.' },
    { kop => 'Kijken wat er vrij is',
      tekst => 'Voor de voorgestelde datum wordt gekeken of er een leenauto beschikbaar is. Zo niet, dan worden er datums voorgesteld waarop dat wel zo is.' },
    { kop => 'Voorwaarden meteen erbij',
      tekst => 'Eigen risico, brandstof, kilometerbeperking, welk rijbewijs en vanaf welke leeftijd. De dingen waar achteraf discussie over ontstaat, staan er vooraf.' },
    { kop => 'Reserveren bij de afspraak',
      tekst => 'De leenauto wordt vastgelegd bij de werkplaatsafspraak, niet los. Daardoor kan hij niet per ongeluk dubbel gaan.' },
    { kop => 'Herinneren en teruggeven',
      tekst => 'Een bericht vooraf over wat er meegenomen moet worden, en een bericht bij teruggave over kilometerstand en tanken.' },
    { kop => 'Wat je erover wil weten',
      tekst => 'Hoe vaak er een leenauto gevraagd werd, hoe vaak er geen vrij was en welke afspraken daardoor niet doorgingen.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · tijdens het inplannen',
    regels => [
      ['Klant',   'Die koppeling, hoelang duurt dat?'],
      ['Helvaro', 'Reken op een volle dag, soms anderhalve. Wil je er een leenauto bij? Dan hoef je niet zonder te zitten.'],
      ['Klant',   'Kan dat? En wat kost het?'],
      ['Helvaro', 'Op dinsdag de 18e staat er een vrij. € 15 per dag, eigen risico € 300, je levert hem in met dezelfde hoeveelheid brandstof. Rijbewijs minimaal een jaar.'],
      ['Klant',   'Prima, dan dinsdag.'],
      ['Helvaro', 'Vastgezet. Dinsdag 18 november vanaf 08:00, koppeling, leenauto gereserveerd. Neem je rijbewijs mee.'],
    ],
    uitkomst => ['Afspraak met leenauto', 'Dinsdag 18 · koppeling · leenauto gereserveerd'],
  },

  opbrengst_titel => 'De drempel voor je duurste klussen.',
  opbrengst => [
    { titel => 'Grote klussen komen los',
      tekst => 'De reparaties met de meeste uren zijn ook de reparaties waarbij vervoer het struikelblok is. Dat blok haal je hier weg.' },
    { titel => 'Je leenauto staat minder stil',
      tekst => 'Een wagen die niemand aanbiedt, verhuurt zichzelf niet. Dit maakt hem onderdeel van elk gesprek waarin hij nuttig is.' },
    { titel => 'Geen dubbele toezeggingen',
      tekst => 'Omdat de reservering aan de afspraak hangt, kan dezelfde auto niet twee keer beloofd worden.' },
    { titel => 'Minder discussie achteraf',
      tekst => 'Voorwaarden die vooraf op papier staan, leveren zelden ruzie op bij de teruggave.' },
  ],

  systeem => {
    tekst => 'Dit is geen losse verhuurmodule. Het is een antwoord dat op het juiste moment in een lopend gesprek valt, en dat is precies waarom het werkt.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Hoelang de klus duurt, en of er dus vervoer nodig is.'],
      ['handelen',  'Handelen',  'Beschikbaarheid nakijken, voorwaarden noemen, reserveren.'],
      ['koppelen',  'Koppelen',  'De reservering hangt aan de werkplaatsafspraak.'],
    ],
    buren => [
      ['werkplaats-inplan-agent', 'Bepaalt hoelang de klus duurt en dus of er een leenauto nodig is.'],
      ['offerte-opvolg-agent',    'Neemt het vervoersbezwaar weg bij een openstaande offerte.'],
      ['schade-intake-agent',     'Regelt vervangend vervoer bij schade, vaak via de verzekeraar.'],
    ],
  },

  grenzen => [
    'Hij sluit geen huurovereenkomst. Het papierwerk teken je bij de balie.',
    'Hij controleert geen rijbewijs en geen leeftijd. Dat gebeurt bij het ophalen.',
    'Hij geeft geen leenauto weg buiten de regels die jij hebt vastgelegd.',
    'Zonder een plek waar je beschikbaarheid bijhoudt, kan hij niets toezeggen.',
  ],

  cta => 'De vraag die je duurste klussen ophoudt.',
},

# ── 08 ─────────────────────────────────────────────────────────────────────
{
  slug => 'schade-intake-agent',
  nr   => '05',
  naam => 'Schade-intake',
  h1   => 'Bij schade begint het werk <span class="highlight">met vragen stellen.</span>',
  lede => 'Voordat je iets kunt zeggen over reparatie of kosten, moet je weten wat er gebeurd is, wie er aansprakelijk is en welke verzekeraar erbij hoort. Die informatie ophalen kost een half uur aan de telefoon, en gebeurt meestal op het drukste moment van de dag.',

  probleem => {
    titel => 'Een klant die net schade heeft, weet zelf ook niet wat hij moet doen.',
    tekst => [
      'Iemand belt na een aanrijding. Hij is van slag, weet niet of hij eerst de verzekeraar moet bellen of eerst de garage, en heeft geen idee welke gegevens er nodig zijn. Jouw balie wordt zo de eerste hulp, en dat kost tijd die er niet is.',
      'Wat er nodig is, is elke keer hetzelfde: kenteken, wat er gebeurd is, foto\'s van de schade, de verzekeraar, het polisnummer en of er tegenpartij is. Zonder die zes kun je niets plannen en niets calculeren.',
      'Een klant die de eerste dag goed geholpen wordt, komt bijna altijd bij die garage terecht voor de reparatie.',
    ],
    gevolgen => [
      'De auto staat er zonder dat iemand weet wie het betaalt.',
      'De calculatie wacht op foto\'s die er niet zijn.',
      'Een klant die aan het lijntje gehouden wordt, rijdt door naar een schadeherstelketen.',
    ],
  },

  werkstroom_sub => 'De zes dingen die je nodig hebt, opgehaald voor de auto binnenrijdt.',
  stappen => [
    { kop => 'Eerst rust, dan gegevens',
      tekst => 'De eerste vraag is of iedereen ongedeerd is en of de auto nog rijdt. Dat bepaalt of er een berger nodig is of een afspraak volstaat.' },
    { kop => 'Kenteken en voertuig',
      tekst => 'Het kenteken levert merk, model en bouwjaar. Dat is de basis voor elke calculatie die erna komt.' },
    { kop => 'Foto’s in het gesprek',
      tekst => 'De klant stuurt foto\'s van de schade, het hele voertuig en de kilometerstand. Via WhatsApp is dat voor de meeste mensen de makkelijkste stap van het hele proces.' },
    { kop => 'Verzekering en aansprakelijkheid',
      tekst => 'Welke verzekeraar, welk polisnummer, wie was aansprakelijk en is er een schadeformulier ingevuld. Precies de vragen waar een klant zelf niet aan denkt.' },
    { kop => 'Een afspraak of een doorverwijzing',
      tekst => 'Rijdt de auto nog, dan wordt er een moment geboekt om te bekijken. Rijdt hij niet, dan gaat het meteen naar een mens.' },
    { kop => 'Het dossier staat klaar',
      tekst => 'Wanneer de auto binnenkomt, ligt alles er al. Je hoeft niet opnieuw te beginnen met vragen stellen.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · de dag van de aanrijding',
    regels => [
      ['Klant',   'Ik ben net achterop gereden, mijn voorbumper is kapot.'],
      ['Helvaro', 'Vervelend. Is iedereen ongedeerd, en rijdt de auto nog?'],
      ['Klant',   'Ja hoor, alleen de bumper en een koplamp.'],
      ['Helvaro', 'Goed om te horen. Stuur me een paar foto’s van de schade en één van de hele auto, en geef het kenteken door.'],
      ['Klant',   '82-ABC-3 · foto’s verstuurd'],
      ['Helvaro', 'Ontvangen. Wie is je verzekeraar, en is er een schadeformulier ingevuld met de tegenpartij?'],
      ['Klant',   'Ja, samen ingevuld. Verzekerd bij Univé.'],
      ['Helvaro', 'Genoteerd. Donderdag 10:00 kun je langskomen zodat we het opnemen en een calculatie maken. Neem het schadeformulier mee.'],
    ],
    uitkomst => ['Dossier compleet', 'Donderdag · 10:00 · schade opnemen · foto’s en polis binnen'],
  },

  opbrengst_titel => 'De eerste dag bepaalt waar de auto gerepareerd wordt.',
  opbrengst => [
    { titel => 'Je bent er terwijl het gebeurt',
      tekst => 'Wie binnen tien minuten reageert bij een aanrijding, is de garage waar die klant naartoe gaat. Ook ’s avonds en in het weekend.' },
    { titel => 'Geen calculatie zonder foto’s',
      tekst => 'De beelden komen binnen op het moment dat de klant er toch al mee bezig is, niet drie dagen later.' },
    { titel => 'Minder uitzoekwerk aan de balie',
      tekst => 'Het halve uur vragen stellen is al gedaan voordat de auto voorrijdt.' },
    { titel => 'Een compleet dossier',
      tekst => 'Verzekeraar, polis, aansprakelijkheid en beeld zitten bij elkaar. Dat scheelt gedoe met de expert.' },
  ],

  systeem => {
    tekst => 'Schade is de werkstroom met de meeste losse gegevens. Precies daarom hoort hij in een systeem dat het gesprek, de foto\'s en de afspraak bij elkaar houdt.',
    lagen => [
      ['opvangen',  'Opvangen',  'Ook ’s avonds en in het weekend, wanneer schade nu eenmaal gebeurt.'],
      ['begrijpen', 'Begrijpen', 'Voertuig, toedracht, aansprakelijkheid en verzekeraar.'],
      ['handelen',  'Handelen',  'Foto\'s ophalen, afspraak maken of doorgeven aan een mens.'],
    ],
    buren => [
      ['leenauto-agent',           'Regelt vervangend vervoer, vaak via de verzekeraar.'],
      ['onderdelen-navraag-agent', 'Zoekt uit of de benodigde delen leverbaar zijn.'],
      ['werkplaats-inplan-agent',  'Plant het opnemen en later de reparatie zelf.'],
    ],
  },

  grenzen => [
    'Hij maakt geen calculatie en noemt geen reparatiebedrag.',
    'Hij beoordeelt geen aansprakelijkheid en doet geen uitspraak over dekking.',
    'Hij meldt de schade niet aan bij een verzekeraar.',
    'Bij letsel of een auto die niet meer rijdt, gaat het meteen naar een mens.',
  ],

  cta => 'De eerste tien minuten na een aanrijding.',
},

# ── 09 ─────────────────────────────────────────────────────────────────────
{
  slug => 'winterbanden-oproep-agent',
  nr   => '09',
  naam => 'Bandenwissel',
  h1   => 'Twee weken per jaar kun je niet aanslepen. <span class="highlight">De rest van het jaar staat de opslag vol.</span>',
  lede => 'Iedereen belt in dezelfde week, en iedereen wil zaterdag. Wie zijn bandenklanten drie weken eerder benadert, spreidt diezelfde omzet over een maand en houdt er tijd aan over voor het werk dat er meer aan verdient.',

  probleem => {
    titel => 'De voorspelbaarste piek van je jaar, elk jaar onvoorbereid.',
    tekst => [
      'In oktober en in april gebeurt hetzelfde. De eerste nachtvorst of de eerste warme week, en dan belt iedereen tegelijk. Je balie staat vol, de telefoon houdt niet op, en je moet mensen wegsturen naar over twee weken.',
      'Ondertussen ligt je opslag vol met banden van klanten die je adresgegevens hebt. Het enige dat ontbreekt, is iemand die ze vanaf half september één voor één benadert.',
      'Bandenwissels zijn op zichzelf geen grote omzet. Maar het is wel het moment waarop je de auto ziet, de profieldiepte meet en de volgende set verkoopt.',
    ],
    gevolgen => [
      'Twee weken chaos in plaats van vier weken gespreid werk.',
      'Klanten die je moet wegsturen, gaan naar de snelservice om de hoek.',
      'Banden die al twee seizoenen in je opslag liggen van klanten die niet meer komen.',
    ],
  },

  werkstroom_sub => 'Dezelfde omzet, over een maand uitgesmeerd in plaats van over twee weken.',
  stappen => [
    { kop => 'Je bandenbestand als lijst',
      tekst => 'Iedereen van wie je banden in opslag hebt, komt in beeld. Dat is een lijst die je al hebt en die meestal niets doet.' },
    { kop => 'Benaderen voor de piek begint',
      tekst => 'Vanaf half september en half maart gaan er berichten uit, verspreid over de weken. Je bepaalt zelf hoeveel per dag, zodat je planning het aankan.' },
    { kop => 'Een datum aanbieden, niet vragen om te bellen',
      tekst => 'Twee concrete momenten in het bericht, waarvan er één doordeweeks is. Dat haalt druk weg van de zaterdag.' },
    { kop => 'Profiel en staat erbij',
      tekst => 'Weet je dat een set bijna op is, dan staat dat in het bericht. Dat is het natuurlijke moment om over nieuwe banden te praten.' },
    { kop => 'Opslag opruimen',
      tekst => 'Klanten van wie de banden al twee seizoenen liggen, krijgen de vraag of ze ze nog willen. Dat scheelt ruimte en discussie.' },
    { kop => 'De piek verdeeld',
      tekst => 'Je ziet hoeveel wissels er per week geboekt staan, zodat je op tijd ziet of het scheefloopt.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · half september',
    regels => [
      ['Helvaro', 'Dag Ruud, je winterbanden liggen bij ons in de opslag. Zullen we de wissel alvast inplannen voordat het druk wordt? Dinsdag 8 oktober om 14:00 of zaterdag 12 oktober om 09:00.'],
      ['Klant',   'Is het al nodig? Het is nog warm.'],
      ['Helvaro', 'Nog niet, maar vanaf eind oktober lopen we vol en dan is zaterdag vaak drie weken vooruit geboekt. Nu vastzetten kost je niets en je hebt de datum die je wil.'],
      ['Klant',   'Doe die dinsdag maar. En hoe staan mijn zomerbanden ervoor?'],
      ['Helvaro', 'Bij de vorige wissel stond er 3,5 mm op de voorbanden. Die halen waarschijnlijk nog één zomer, maar niet twee. We meten ze na en dan hoor je het.'],
    ],
    uitkomst => ['Vastgezet, voor de piek', 'Dinsdag 8 oktober · 14:00 · bandenwissel · 45 min'],
  },

  opbrengst_titel => 'Dezelfde klanten, minder chaos.',
  opbrengst => [
    { titel => 'De piek wordt een periode',
      tekst => 'Vier weken gespreid werk in plaats van twee weken waarin je mensen moet wegsturen.' },
    { titel => 'Doordeweeks vullen',
      tekst => 'Door doordeweekse momenten als eerste aan te bieden, haal je druk van de zaterdag af.' },
    { titel => 'Banden verkopen op het juiste moment',
      tekst => 'De wissel is het enige moment waarop je de profieldiepte ziet. Dat gesprek voeren is makkelijker als het al in het bericht stond.' },
    { titel => 'Je opslag loopt leeg',
      tekst => 'Sets van klanten die niet meer komen, worden opgehaald of weggedaan. Dat scheelt ruimte die je nodig hebt.' },
  ],

  systeem => {
    tekst => 'Dit is een seizoenswerkstroom die twee keer per jaar aangaat. Omdat hij in hetzelfde systeem zit, weet hij wie er ondertussen al voor iets anders geweest is.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Welke klant, welke set, wat er bij de vorige wissel gemeten is.'],
      ['handelen',  'Handelen',  'Benaderen, een datum aanbieden en vastzetten.'],
      ['koppelen',  'Koppelen',  'De wissels komen gespreid in je planning te staan.'],
      ['meten',     'Meten',     'Hoeveel benaderd, hoeveel geboekt, hoe de weken verdeeld zijn.'],
    ],
    buren => [
      ['werkplaats-inplan-agent',           'Zorgt dat de wissels niet allemaal op dezelfde ochtend vallen.'],
      ['onderhoudsbeurt-herinnering-agent', 'Combineert de wissel met een beurt als die toch bijna aan de beurt is.'],
      ['no-show-agent',                     'Bevestigt en herinnert, want in een drukke week is een gat extra duur.'],
    ],
  },

  grenzen => [
    'Hij verkoopt geen banden en noemt geen prijzen die jij niet hebt vastgelegd.',
    'Hij beoordeelt niet of een band nog goed is. Dat meet je monteur.',
    'Hij gooit geen opgeslagen banden weg. Hij vraagt het alleen na.',
    'Zonder een bestand met wie welke banden in opslag heeft, valt er weinig te benaderen.',
  ],

  cta => 'Begin in september. Niet in de week van de vorst.',
},

# ── 10 ─────────────────────────────────────────────────────────────────────
{
  slug => 'onderhoudsbeurt-herinnering-agent',
  nr   => '07',
  naam => 'Onderhoudsbeurt',
  h1   => 'Hij komt echt nog wel een keer. <span class="highlight">Alleen niet bij jou.</span>',
  lede => 'De klant van vorig jaar heeft geen klacht en is niet boos. Hij is je gewoon vergeten, en rijdt door tot er iets kapotgaat. Dan belt hij degene die het dichtst bij is of die hem het laatst iets stuurde.',

  probleem => {
    titel => 'Een klantenbestand dat langzaam leegloopt.',
    tekst => [
      'In elk autobedrijf staan honderden namen van mensen die ooit klant waren. Ze zijn niet weggegaan na ruzie, er is gewoon niets meer gebeurd. Onderhoud is het soort ding dat je uitstelt tot je eraan herinnerd wordt, en dat herinneren doet niemand.',
      'Merkdealers doen dit wel, en daarom houden ze klanten langer vast. Niet omdat ze beter werk leveren, maar omdat er een systeem achter zit dat op tijd een bericht stuurt.',
      'Het goede nieuws is dat deze klanten je al kennen. Ze hoeven niet overtuigd te worden, alleen herinnerd.',
    ],
    gevolgen => [
      'Uitgesteld onderhoud wordt duurdere reparatie, meestal elders.',
      'Je bestand groeit op papier en krimpt in werkelijkheid.',
      'Je rustige weken blijven rustig terwijl de namen gewoon klaarstaan.',
    ],
  },

  werkstroom_sub => 'Op kilometerstand of op datum, wat er bij jou het beste werkt.',
  stappen => [
    { kop => 'Je eigen interval, niet een standaard',
      tekst => 'Je bepaalt zelf of je op kilometers rekent, op maanden, of op wat de fabrikant voorschrijft per model. Er is geen vast schema dat overal klopt.' },
    { kop => 'De lijst komt eruit',
      tekst => 'Wie zit tegen de volgende beurt aan, en wie is er al overheen. Dat tweede groepje is vaak het grootst en het meest vergeten.' },
    { kop => 'Een bericht dat de auto kent',
      tekst => 'Niet "tijd voor onderhoud", maar "je Passat stond in maart op 158.000, dat is inmiddels waarschijnlijk rond de 175.000". Dat leest als een garage die meedenkt.' },
    { kop => 'Meteen een moment aanbieden',
      tekst => 'Met de juiste duur voor een kleine of grote beurt, en de vraag of hij wil wachten of brengen.' },
    { kop => 'Combineren waar het kan',
      tekst => 'Is de APK ook binnenkort aan de beurt, of ligt er nog een bandenwissel, dan wordt dat in één afspraak voorgesteld. Dat scheelt de klant een rit.' },
    { kop => 'Wie niet reageert, wordt niet vergeten',
      tekst => 'Geen eindeloze herhaling, maar wel een nieuwe poging bij het volgende natuurlijke moment.' },
  ],

  gesprek => {
    kanaal => 'WhatsApp · veertien maanden na het laatste bezoek',
    regels => [
      ['Helvaro', 'Dag Ingrid, in maart vorig jaar deden we de beurt van je Passat, toen stond hij op 158.000 km. Inmiddels zul je daar ruim overheen zijn. Zullen we de volgende inplannen?'],
      ['Klant',   'Klopt, hij staat op 176.000. Moet er dan ook iets anders gebeuren?'],
      ['Helvaro', 'Bij deze stand hoort een grote beurt, reken op ongeveer drie uur. En je APK loopt af op 2 februari, die kunnen we in dezelfde afspraak meenemen. Dan ben je in één keer klaar.'],
      ['Klant',   'Dat is handig. Kan het op een vrijdag?'],
      ['Helvaro', 'Vrijdag 23 januari om 08:00, dan heb je hem ’s middags terug.'],
      ['Klant',   'Top.'],
    ],
    uitkomst => ['Twee klussen, één afspraak', 'Vrijdag 23 januari · 08:00 · grote beurt en APK · 4 uur'],
  },

  opbrengst_titel => 'Klanten die je al had.',
  opbrengst => [
    { titel => 'Geen nieuwe klanten nodig',
      tekst => 'Deze mensen kennen je bedrijf al. Ze hoeven niet overtuigd te worden, alleen op het juiste moment aangesproken.' },
    { titel => 'Twee klussen in één afspraak',
      tekst => 'Beurt en keuring samen is meer omzet per bezoek en een rit minder voor de klant. Iedereen wint daarbij.' },
    { titel => 'Rustige weken vullen',
      tekst => 'Omdat je zelf bepaalt hoeveel berichten er per dag uitgaan, kun je deze lijst gebruiken om gaten te dichten.' },
    { titel => 'Uitstel wordt onderhoud in plaats van reparatie',
      tekst => 'Een beurt op tijd is goedkoper dan de schade die uitstel oplevert, en dat is een gesprek dat je makkelijk voert.' },
  ],

  systeem => {
    tekst => 'Dit is de werkstroom die het meest van je bestaande gegevens vraagt en er ook het meest uithaalt. Hij werkt beter naarmate je koppeling met je pakket beter is.',
    lagen => [
      ['begrijpen', 'Begrijpen', 'Laatste bezoek, kilometerstand, interval en de APK-datum.'],
      ['handelen',  'Handelen',  'Benaderen, voorstellen en vastzetten, met klussen gecombineerd.'],
      ['koppelen',  'Koppelen',  'Klanthistorie uit je pakket maakt dit een stuk scherper.'],
      ['meten',     'Meten',     'Hoeveel slapende klanten er weer een afspraak maakten.'],
    ],
    buren => [
      ['apk-herinnering-agent',   'Wordt gecombineerd zodra beide binnen dezelfde periode vallen.'],
      ['winterbanden-oproep-agent', 'Kan in dezelfde afspraak mee wanneer het seizoen klopt.'],
      ['werkplaats-inplan-agent', 'Reserveert de juiste tijd voor een kleine of grote beurt.'],
    ],
  },

  grenzen => [
    'Hij verzint geen kilometerstand. Zonder gegevens over het laatste bezoek valt er weinig te zeggen.',
    'Hij bepaalt niet welk onderhoud er nodig is, alleen dat het moment nadert.',
    'Hij benadert niemand die heeft aangegeven geen berichten te willen.',
    'Hij blijft niet herhalen bij mensen die stelselmatig niet reageren.',
  ],

  cta => 'Je volgende klant staat al in je bestand.',
},
];
