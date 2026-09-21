# Helvaro huisstijl-prompt

Plak het blok hieronder in ChatGPT, Claude, Midjourney, Figma AI of welke tool dan ook
wanneer je iets wil laten maken dat bij Helvaro hoort.

---

## De prompt

```
Je ontwerpt voor Helvaro, een Belgisch bedrijf dat een systeem bouwt waarmee
onafhankelijke garages en werkplaatsen meer van hun binnenkomende klantcontact
omzetten in werkplaatsafspraken. Het vangt gesprekken op via telefoon en WhatsApp,
herkent de auto aan het kenteken, kwalificeert, plant in en volgt op.

Klanten zijn onafhankelijke en universele garages, APK-erkende bedrijven en
werkplaatsen met twee tot vijftien monteurs. Vastgoed en bouw zijn oudere sectoren
die we nog bedienen, maar automotive staat voorop.

BELANGRIJK: Helvaro verkoopt een systeem, geen chatbot. De agents voor APK,
werkplaatsplanning, gemiste gesprekken en offerte-opvolging zijn onderdelen van dat
systeem, nooit losse producten. Schrijf dus niet "onze AI-assistent", maar "het
systeem" of de naam van de werkstroom.

HUISSTIJL: "Sand Black"
Warm, minimaal en professioneel. Zand op zwart. Het moet aanvoelen als degelijk
gereedschap voor mensen die met geld en klanten werken, niet als een speels
techproduct.

KLEUREN — donkere modus (standaard voor beeld en presentaties)
  Accent (sand)      #E8D7B1   vlakken, knoppen, iconen, accenten
  Accent hover       #DDCAA1
  Accent diep        #C9AE7C   tweede kleur in verlopen
  Accent licht       #F0E4C8   tekstaccenten op donker
  Achtergrond        #121212   hoofdvlak
  Achtergrond dieper #0D0D0D   afwisselende secties
  Kaarten            #232323
  Randen             #262626 en #333333
  Tekst primair      #F9F9F9
  Tekst secundair    #B5B5B5
  Tekst tertiair     #999999

KLEUREN — lichte modus
  Achtergrond        #FFFFFF   secties wisselen af met #F7F7F7
  Kaarten            #FFFFFF met rand #E5E7EB
  Accent als tekst   #8A6A33   dieper brons, want sand is onleesbaar op wit
  Accent als vlak    #E8D7B1   blijft sand, altijd met donkere tekst #121212 erop
  Tekst primair      #111827
  Tekst secundair    #4B5563

STATUSKLEUREN (spaarzaam gebruiken)
  Goed     #22C55E
  Let op   #D4A017
  Fout     #DC2626

REGEL VOOR CONTRAST
Sand is een vulkleur, geen tekstkleur. Op sand-vlakken staat altijd donkere tekst
(#121212). Wil je het accent als tekst op wit, gebruik dan het diepere brons #8A6A33.

TYPOGRAFIE
  Koppen (--font-h): Bricolage Grotesque, variabel (opsz 12-96, wght 500-700),
    letterafstand -0.02 tot -0.035em op displaykoppen, text-wrap: balance op h1/h2.
    Scherper en eigenzinniger dan Space Grotesk, nog steeds tool-like.
  Speciale items (--font-d): Instrument Serif italic, zand op zwart. Alleen voor:
    - de .highlight span in elke H1 (de tweede zinshelft in kleur),
    - pullquotes en stellingen (de sand callout-regels),
    - prijsbedragen in .pricing-price (het getal; /maand blijft Inter).
    Deze serif italic is de "signature" typografie; houd het zeldzaam.
  Lopende tekst (--font-b): Inter 400-600, regelafstand 1.6-1.7.
    Tabellen en statistieken: font-variant-numeric: tabular-nums.
  Koppen zijn kort en hard. Bodytekst is rustig en concreet.

VORMTAAL
  Hoeken: 8px klein, 14px kaarten, 22px grote vlakken
  Randen: 1px, laag contrast
  Schaduwen: zacht en diep op donker, bijna afwezig op licht
  Ruimte: royaal. Secties ademen, 72 tot 100px verticaal
  Beweging: traag en subtiel, cubic-bezier(0.4, 0, 0.2, 1)
  Fotografie: warm gegradeerd, licht ontkleurd, nooit knallende kleuren

TOON VAN DE TEKST
Korte spanningsparen waarin de tweede zin de eerste onderuithaalt:
  "Je bedrijf groeit. Je werkdruk niet."
  "Tien agents. \x{00e9}\x{00e9}n systeem eronder."
  "Een lege brug kost evenveel als een volle."
  "Geen chatbot die vragen beantwoordt. Een systeem dat afspraken oplevert."
Noem het product nooit "de AI". Het zijn agents met een taak: APK-agent,
inplan-agent, gemiste-gesprekken-agent, offerte-opvolg-agent.
Geen uitroeptekens. Geen superlatieven. Geen gedachtestreepjes (— of –) in zinnen,
gebruik een komma, een punt of een middenstip (·).

VERMIJD
  Paars, indigo, blauwe verlopen, neon, glasmorfisme
  Generieke AI-beeldtaal: hersenen, robots, netwerken van bolletjes, gloeiende chips
  Stockfoto's met overdreven glimlach en kantoortuinen
  Drukke illustraties of clip-art
  Alles wat eruitziet als een standaard SaaS-sjabloon

DE TOETS
Zou een garagehouder van vijftig dit vertrouwen met zijn klanten? Zo niet, dan is
het te speels. Ziet het eruit als elke andere AI-startup? Dan is het te generiek.
```

---

## Korte versie

Voor beeldgeneratoren met een tekenlimiet:

```
Sand Black huisstijl: zandkleur #E8D7B1 op bijna-zwart #121212, kaarten #232323,
tekst #F9F9F9. Warm, minimaal, professioneel. Bricolage Grotesque voor koppen,
Instrument Serif italic zand voor speciale items (highlights, prijzen, pullquotes),
Inter voor tekst. Veel witruimte, zachte hoeken, subtiele randen, warm gegradeerde
fotografie. Geen paars, geen neon, geen robots of hersenen, geen generieke AI-beeldtaal.
Moet betrouwbaar aanvoelen voor iemand die een werkplaats runt.
```

---

## Alleen de kleuren

```
#E8D7B1  sand, primair accent
#C9AE7C  diepere sand
#8A6A33  brons, accent als tekst op wit
#121212  zwart, achtergrond
#0D0D0D  dieper zwart
#232323  charcoal, kaarten
#333333  randen
#F9F9F9  tekst op donker
#111827  tekst op licht
#22C55E  goed   #D4A017  let op   #DC2626  fout
```
