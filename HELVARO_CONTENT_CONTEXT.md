# HELVARO — CONTENT CONTEXT

**A brand operating system for AI assistants.**
Read this before writing any Helvaro post, caption, visual brief, website copy or campaign idea.

Written: 23 September 2026 · Derived from the live repository `UseHelvaro/Helvaro-Website` (branch `main`, HEAD `57a69ed`) and the assets in it.
Everything here is traceable to a file in this repo. Where the repo contradicts itself, that is recorded explicitly in §20 rather than smoothed over.

---

## 0. HOW TO USE THIS FILE

You are writing for a **Belgian company selling a sales system to independent car dealers**. Not a generic AI startup. Not a chatbot vendor. Not a productivity-tool company.

Three rules govern everything below:

1. **Start from the operational problem, never from the technology.** The reader is a dealer principal with 40–300 cars on the lot. He does not care that it is AI. He cares that a buyer asked about the Passat at 23:40 and nobody answered until 09:15.
2. **Never state a number, result or capability that is not in this file or in the repo.** Helvaro has *no measured customer results yet* and says so publicly. Inventing one destroys the single thing the brand is built on. See §16.
3. **Faro is a falcon, not a robot and not an orange geometric character.** See §8 before commissioning any visual.

If you need something this file does not cover, go read the actual page in the repo. Do not guess. See §21 for the source-of-truth order.

---

## 1. WHAT HELVARO IS

### The one-line version

> Helvaro is a system that handles the vehicle enquiries coming into a car dealership — over the website, WhatsApp and e-mail — answers them using the dealer's own stock data, qualifies the buyer, follows up, and books the appointment. The salesperson keeps control and takes over whenever it matters.

Homepage H1, verbatim: **"Elke voertuigaanvraag. Afgehandeld."**
Homepage kicker: **"Het verkoopsysteem voor autobedrijven"**
Homepage sub: *"Helvaro handelt aanvragen af via je website, WhatsApp en e-mail. Het weet over welke auto het gaat, kwalificeert de kans, volgt op en boekt de afspraak. Je verkoper houdt de regie."*
Anti-positioning line directly under it: *"Geen chatbot op je website. Het systeem dat je aanvragen omzet in afspraken."*

### The problem it solves

Not lead generation. **Lead handling.** The site is explicit:

> "Je hebt geen tekort aan leads. Je hebt een aanvraagprobleem."
> "De vraag komt binnen. Wat er in de tien minuten daarna gebeurt, bepaalt bij wie die auto verkocht wordt."

The five failure modes named on the homepage — memorise these, they are the raw material for most content:

| # | Failure | The line |
|---|---|---|
| 01 | Enquiry arrives at 21:43 | *"Je verkoper leest het morgenochtend. Tegen die tijd heeft hij het bij drie anderen ook gevraagd."* → **"Wie als eerste antwoordt, verkoopt."** |
| 02 | Salesperson is already with a customer | *"Die blijft liggen tot het rustig is, en dat is het vandaag niet meer."* → **"Een koper die wachtte, wacht niet lang."** |
| 03 | The same five questions all day | *"Je beste verkoper typt dat dertig keer per week over."* → **"Verkooptijd die naar tikwerk gaat."** |
| 04 | The enquiry disappears into a mailbox | *"Er is geen dossier, geen status en geen volgende stap."* → **"Bestaat wel, leeft niet."** |
| 05 | Follow-up depends on somebody's memory | *"Drie dagen later weet niemand meer wie dat was."* → **"De tweede kans komt er nooit."** |

Closing line of that section: *"Geen van deze vijf gaat over te weinig belangstelling. Ze gaan allemaal over kopers die je al had."*

### The three-name hierarchy — get this right

From `systeem.html`, section "Helvaro, Faro en de werkstromen":

- **Helvaro** = *het systeem*. "Opvangen, begrijpen, handelen, koppelen en meten. Dit is wat je koopt."
- **Faro** = *het gezicht*. "De laag waarin je meeleest, goedkeurt en ziet welke gesprekken je aandacht nodig hebben. **Faro is niet het product, Faro is hoe je het bedient.**"
- **De werkstromen** = *het werk*. Eight of them, all inside the same system.

Never write **"de AI"** or **"onze AI-assistent"** as the name of the product. Write **"het systeem"**, or name the workflow (*de nieuwe-aanvraag-werkstroom*, *de opvolging*).

Nuance: **"agent" is live vocabulary** and is not banned. The agent pages are headed "Agent 01 van tien" and every one closes with "Wat deze agent niet doet". What the rule forbids is treating the product as a single AI assistant. Preferred hierarchy: *het systeem* (the thing you buy) > *de werkstroom* / *de agent* (a route through it) > never *de AI*.

### The five layers (`systeem.html`)

Section heading: **"Waar een chatbot stopt, begint de rest."**
Framing line: *"De eerste drie lagen kun je bij tientallen leveranciers kopen. De laatste twee bepalen of er ook werkelijk iets verandert in je verkoop."*

| Layer | Name | One-liner |
|---|---|---|
| 01 | **Opvangen** | "Niets komt binnen zonder dat iemand reageert." |
| 02 | **Begrijpen** | "De auto erbij, niet alleen de vraag." |
| 03 | **Handelen** | "Antwoorden is het begin, niet het einde." |
| 04 | **Koppelen** | "Je voorraad is de bron, niet een kopie." |
| 05 | **Meten** | "Wat je niet telt, verbetert niet." |

Faro's line on this section: *"Een chatbot doet laag drie en stopt daar. Wij doen ze alle vijf."* — this is the single sharpest competitive sentence the brand owns.

### The eight werkstromen

From `agents/index.html` — *"Acht werkstromen. Eén systeem eronder."* / *"Dit zijn geen acht losse producten. Het zijn acht routes door hetzelfde systeem: dezelfde koper, dezelfde wagen, hetzelfde dossier."*

| # | Werkstroom | What it does | Hard limit |
|---|---|---|---|
| 01 | **Nieuwe aanvraag** | Identifies the car, answers from stock, offers two concrete slots, opens a dossier | Does not negotiate price |
| 02 | **Proefrit** | Checks the car is actually free, proposes two moments, confirms, reminds the day before | Does not check the driving licence — that happens at key handover |
| 03 | **Voertuigadvies** | Asks four questions, shows 3–5 cars from stock and explains the difference | Only cars in stock; no technical reliability advice not in the data |
| 04 | **Inruil** | Collects make, year, fuel, mileage, history, damage, 4 photos around + 1 of the odometer | **Never names a trade-in value, not even approximately** |
| 05 | **Financiering** | Explains what the monthly figure depends on, captures term and trade-in, routes to a human | Calculates no monthly amount the dealer has not stored; asks no financial data |
| 06 | **Opvolging** (file: `gemiste-aanvraag`) | Three touches: day ~2 something useful, ~1 week a concrete slot, ~2 weeks a polite close | **Stops after three messages**; honours opt-outs |
| 07 | **E-mail** | Reads the shared mailbox, separates enquiries from invoices, replies in the same register | Does not answer mail that is not about a car; angry/legal mail goes straight to a human |
| 08 | **WhatsApp** | One business number for the company, photos both ways, seller reads along and takes over | Never messages people who did not make contact; no bulk campaigns |

Sequencing advice the brand gives publicly — use this, it is good content: *"Alles tegelijk aanzetten klinkt efficiënt en werkt zelden. Eén aanzetten, vier weken meten, dan de volgende."*

### ⚠️ Five layers vs five steps — do not mix them up

There are **two different fives** on the site.

- **The five layers** (`systeem.html`) — Opvangen, Begrijpen, Handelen, Koppelen, Meten. This is the *architecture* argument, used against chatbots.
- **The five steps** (`index.html`, "Van aanvraag tot afspraak · Vijf stappen. Eén systeem.") — this is the *customer journey*:
  1. Een koper vraagt naar een auto (website, WhatsApp of e-mail, binnen of buiten openingsuren)
  2. Helvaro antwoordt met de auto erbij (uit jouw voorraad, *"niet uit een gok"*)
  3. Het gesprek wordt een dossier (*"Wat de koper zegt, komt in het dossier. Wat hij niet zegt, wordt niet verzonnen."*)
  4. Stilte krijgt een vervolg (*"'Ik denk er nog over na' is geen eindpunt."*)
  5. Je verkoper neemt over wanneer het telt

For a post about how it works day to day, use **the five steps**. For a post about why this is not a chatbot, use **the five layers**.

### The homepage section inventory (raw material)

In order, with the headline that carries each:

| Section | Headline |
|---|---|
| Hero | "Elke voertuigaanvraag. **Afgehandeld.**" |
| Three channels | "Zo komt een koper binnen. **Zo gaat hij verder.**" |
| One system | "Ander kanaal. **Zelfde systeem.**" |
| Channel switching | "Je koper wisselt van kanaal. **Het gesprek niet.**" |
| The problem | "Je hebt geen tekort aan leads. **Je hebt een aanvraagprobleem.**" |
| The journey | "Vijf stappen. **Eén systeem.**" |
| Vehicle knowledge | "Het kent de auto's **die jij verkoopt.**" |
| Qualification | "Een gesprek is nog geen kans. **Dit wel.**" |
| Handover | "Automatisch waar het kan. **Een mens waar het moet.**" |
| Faro (in ontwikkeling) | "Je voorraad is ook **je content.**" |
| Pricing | "Eén prijs. **Geen verrassingen.**" |
| Pilot | "We zoeken vijf autobedrijven die mee willen meten." |

### The example dossier — the most reusable product asset

From the qualification section of the homepage. Reuse the *shape*, and always carry the label with it:

```
Thomas Peeters                      Warm
Voertuig       BMW X5 xDrive30d
Budget         € 45.000 tot 50.000
Termijn        1 tot 3 maanden
Financiering   Interesse
Inruil         Audi A4, 2018
Afspraak       Zaterdag 14:00
Kanalen        Website, WhatsApp
Laatste contact Gisteren 21:46
```

Its label, verbatim — **use this exact wording whenever you show figures**:
> *"Voorbeeldweergave. De velden vullen zich met wat de koper zelf zegt. Zegt hij niets over budget, dan blijft dat veld leeg."*

And the four things the page says explicitly do **not** happen: no budget is guessed that the buyer did not state · no trade-in value is promised · a browser is not forced to hand over details · an e-mail address **or** a phone number is enough, not both.

---

## 2. CAPABILITY LEDGER — what you may and may not claim

The site maintains a **three-word status vocabulary**, and the CSS comment says why it exists: *"Het hele punt van deze site is dat die drie uit elkaar te houden zijn."*

From `koppelingen/index.html`:

- **live** — *"Het draait bij een autobedrijf. Je kunt het in een demo zien werken, met echte gegevens. Niet 'bijna af', niet 'in de testomgeving'."*
- **in ontwikkeling** — *"Er is code, maar het staat nog niet bij een klant. We noemen geen opleverdatum die we niet kunnen halen."*
- **gepland** — *"Het staat op de lijst. Er ligt nog niets."*

### Status table (authoritative)

| Capability | Status | Notes |
|---|---|---|
| Website widget (one script on the existing site) | **LIVE** | Page-level vehicle context |
| WhatsApp (one business number for the company) | **LIVE** | No "WhatsApp Business API" wording is used anywhere on the site — say *"een zakelijk WhatsApp-nummer"* |
| Stock / voorraad via file or existing ad feed | **LIVE** | Direct connection to a stock system is *in ontwikkeling* |
| Google Agenda as availability source + booking | **LIVE** | The only third-party brand named on the *current-generation* pages besides WhatsApp. Older pages also name HubSpot, Teamleader, Pipedrive (as roadmap) and ChatGPT/Zapier (as comparisons) |
| Qualification + scoring into a dossier | **LIVE** | |
| Human takeover mid-conversation | **LIVE** | |
| Action log, exportable | **LIVE** | |
| CSV export to any CRM | **LIVE** | Plan-gated: excluded on Starter, included from Growth up. Same for the visualisatie-agent and "40 talen" |
| **E-mail workflow** | **IN ONTWIKKELING** | ⚠️ contested — see §20.3 |
| Direct stock-system integration | **IN ONTWIKKELING** | |
| Faro content suggestions from your stock | **IN ONTWIKKELING** | Labelled on the homepage itself |
| Direct CRM integration (HubSpot / Teamleader / Pipedrive) | **GEPLAND** | *"staat op de lijst, maar draait nog nergens"* |
| Other calendars than Google Agenda | **NOT AVAILABLE** | "per geval bekeken" |
| **Telephony / voice** | **DELIBERATELY NOT BUILT** | *"Telefonie staat er bewust niet bij. Dat is vandaag geen onderdeel van het product, en we zetten het er pas op als het dat wel is."* |

### Things the product deliberately refuses to do

These are **positioning assets, not weaknesses**. Lead with them.

- **Geen prijsafspraken.** *"Er wordt niet onderhandeld en er gaat geen euro van de vraagprijs af."*
- **Geen inruilbedrag.** *"De gegevens worden opgehaald, het bedrag noemt een mens. Een getal uit een systeem is later niet meer terug te draaien."*
- **Geen verzonnen voertuiggegevens.** *"Wat niet in jouw voorraad staat, wordt niet beweerd. Liever 'dat zoek ik na' dan een verkeerde uitvoering."*
- **Geen vervanging van je verkopers.** *"Het neemt het herhaalwerk over. De gesprekken waar het geld in zit, komen nog steeds bij een mens terecht."*
- **Geen telefoon.**
- **Geen beloofde cijfers.**

Faro compresses all six into one line: *"Geen prijsafspraken, geen inruilbedrag, geen telefoon. Liever nu duidelijk dan in maand drie."*

**Every agent page and every integration page carries its own limits list** — "Wat deze agent niet doet" and "Wat nog niet kan". That is the richest seam of content on the site (pillar 5). Examples worth knowing: the stock integration cannot reserve a car or change its status; the calendar integration supports Google Agenda only, cannot set per-salesperson availability, and takes no deposits; the website widget cannot replace a stock module or take payments; WhatsApp cannot message people who did not make contact, cannot run campaigns to your database, and cannot migrate conversations off a salesperson's private phone (*"Dat is geen keuze van ons maar een regel van WhatsApp."*).

### Control and governance (`controle.html`) — six commitments

1. **Je verkoper neemt over** — *"De koper merkt geen overdracht, hij krijgt gewoon antwoord van een mens."*
2. **Elk gesprek leesbaar** — *"Een samenvatting is nooit het enige wat overblijft."*
3. **Goedkeuring per actietype** — *"Per type, niet één schakelaar voor alles. Een prijs noemen is iets anders dan een proefrit vastzetten."*
4. **Actielogboek** — *"Exporteerbaar, ook wanneer je verzekeraar of je revisor ernaar vraagt."*
5. **Data in de EU** — processing in the EU, published subprocessor list, DPA, retention period the customer sets
6. **Noodstop** — *"Je zet elke werkstroom zelf stil, meteen, zonder ons te bellen. Per werkstroom, niet alles tegelijk."*

Plus the honesty clause: *"Wat we **niet** beweren: dat er nooit een fout gemaakt wordt."*

### Regulatory posture (`privacybeleid.html`)

Real, usable trust material — most competitors have none of this written down:

- Explicit EU AI Act (Verordening 2024/1689) transparency section, in force since 2 August 2026.
- The agent **discloses it is an AI in its first message** and never claims a human identity. Ask for a human and the conversation is handed over.
- **Conversations are never used to train models.**
- Google Calendar: only a refresh token, the account e-mail and the calendar ID are stored. **Calendar contents are never written to the database.** Private events show as "Bezet" only. Token encrypted AES-256-GCM; if encryption fails, Helvaro refuses to store the token rather than storing it in the clear.
- No emotion recognition, no biometrics, no deepfakes or cloned voices, no hidden manipulation.

---

## 3. AUDIENCE

### Primary ICP — independent car dealers (automotive is the front door)

From `automotive.html`, verbatim:

**Dit past bij**
- Onafhankelijke autobedrijven en occasiondealers
- Bedrijven met **veertig tot driehonderd wagens** op voorraad
- Verkoopteams van **twee tot acht mensen**
- Bedrijven die adverteren op portalen en op hun eigen site
- Wie genoeg aanvragen krijgt, maar er te weinig van omzet

**Dit past niet bij**
- Merkdealers met een eigen contactcentrum en vaste scripts
- Groepen die alles centraal willen aansturen vanuit één systeem
- Handel die alleen aan andere handelaren verkoopt
- Wie een gratis chatbot zoekt voor op de website

Closing: *"Als je hier staat, zeggen we dat liever in het eerste gesprek dan in maand drie."*

**The anti-ICP list is a content asset.** Faro's line: *"Rechts staat voor wie dit niet is. Die lijst kost ons klanten en levert er betere op."*

#### Their actual day — "Een donderdag" (`automotive.html`)

The single best source of post material in the whole repo. Six moments, each with what happens *without* a system:

| Time | What happens | Without a system |
|---|---|---|
| **07:20** | Somebody asked at 23:40 via the form whether the Passat is still there. The mail sits under six others. | *"Hij heeft om 23:55 bij twee andere bedrijven hetzelfde gevraagd. Daar antwoordde er één binnen het uur."* |
| **10:05** | Salesperson is out on a test drive; two site messages and one WhatsApp arrive. | *"Ze worden aan het eind van de middag beantwoord. Twee van de drie reageren dan niet meer."* |
| **11:40** | "Wat is mijn auto waard?" — no plate, no mileage, no photos. | *"Na de tweede mail haakt hij af. Je weet nooit welke wagen hij bedoelde."* |
| **14:15** | "Wat kost dat per maand?" on a €24.500 car. | *"Er komt 'daar bellen we u over terug'. Dat gebeurt twee dagen later, of niet."* |
| **17:50** | Fourteen conversations that went quiet. | *"Het werk om ze binnen te halen was al gedaan en verdampt alsnog."* |
| **21:30** | The busiest two hours of the website. | *"Om 21:45 hadden ze al ergens een afspraak kunnen staan."* |

Closing: *"Zes momenten op één donderdag. Geen ervan gaat over te weinig belangstelling, en geen ervan is op te lossen door harder te werken."*

#### What makes them sceptical

- "What will it say to my customers when I am not watching?" → answer with §2 control commitments.
- "Will it give away my margin?" → no negotiation, no trade-in figure, ever.
- "Is this another chatbot?" → layer three vs all five.
- "Will it invent things about my cars?" → *"Staat er iets niet in, dan zegt het systeem dat het het niet weet."*
- "Will I have to migrate?" → one script, your stock file, one workflow. *"Geen migratie en geen maandenlange invoering."*

#### Their vocabulary (Flemish, sales floor — NOT workshop)

Use: `aanvraag`, `voorraad`, `wagen`, `occasion`, `occasiondealer`, `merkdealer`, `verkoper`, `de vloer`, `het terrein`, `showroom`, `proefrit`, `inruil`, `financiering`, `uitvoering` vs `uitrusting`, `kilometerstand`, `bouwjaar`, `historiek`, `vraagprijs`, `koopsignaal`, `portalen`, `zoekertje`, `werf` (construction only).

Do **not** use on automotive content: `keuring`, `herkeuring`, `APK`, `werkplaats`, `beurt`, `monteur`, `brug`. The site was repositioned away from the workshop/aftersales story in commit `1a9007a`; none of those words appear on `automotive.html` any more. Older Helvaro social batches used them — they are out of date for the sales story.

Belgian, not Dutch: **`nummerplaat`** not `kenteken` (the repo has one leftover `kenteken` on `automotive.html:331` — do not copy it), `wagen` not `auto` where it reads naturally, `herstelling` not `reparatie`.

### Secondary verticals (still live, still sold, deliberately behind automotive)

Footer group "Bedrijf" links to three sector pages. They use an older generation of copy (the "werkaudit / agent / lead" vocabulary) and share one skeleton.

| Vertical | Page | Audience | Core pain | What the agent does |
|---|---|---|---|---|
| **Vastgoed** | `sectoren/vastgoed.html` | Estate agencies / makelaars, both buyers and sellers | *"Het probleem is de timing, niet je team"* — reactions to a zoekertje come outside office hours; the candidate is comparing three other agencies | Answers fast, qualifies (own use vs investment, bedrooms, budget, urgency), books the viewing in the right makelaar's calendar, follows up after the visit, spots sellers ("wie vraagt wat zijn woning waard is, is geen koper") |
| **Bouw & renovatie** | `sectoren/bouw.html` | Construction/renovation firms with a calculation team | *"Twee soorten verlies"* — hours lost to people who only wanted a ballpark, and quotes nobody ever chased. *"Die tweede stapel is bij de meeste bedrijven groter dan de eerste."* | Qualifies before you calculate (type, timing, location, budget), sorts on feasibility, books a site visit, chases quotes until yes or no, revives old quotes |
| **Keukens** | `sectoren/keuken.html` | Kitchen retailers with a showroom and a front desk | Two moments you lose it: evenings/weekends, and mid-day when the showroom is full | Qualifies (budget range, timing, new-build vs replacement), books an opmeting or showroom visit, follows up quotes, revives old ones |

All three also get the **visualisatie-agent**: generates images of a property/kitchen in different styles so a hesitating customer sees the options before the quote or the measurement. This is the only place image generation is sold as a feature.

**Content rule for verticals:** automotive is the default. Only write vertical content when explicitly asked, and then use that vertical's own pain language — do not port car vocabulary into a kitchen post.

---

## 4. COMMERCIAL FACTS

| Item | Fact | Source |
|---|---|---|
| Starter | **€249,99/maand** — 3.000 credits ≈ 150 gesprekken, 1 agent | `index.html#prijzen` |
| Growth *(Meest gekozen)* | **€499/maand** — 10.000 credits ≈ 500 gesprekken, 3 agents, visualisatie-agent, 40 talen | idem |
| Scale *(Meest compleet)* | **vanaf €799/maand** — onbeperkte credits, fair-use (practical ceiling ~20.000 credits ≈ 1.000 gesprekken) | idem |
| Credit maths | 1 gesprek ≈ 20 credits; credits cover conversations **and** generated images | idem |
| Overage | *"Credits op is nooit gesprek op."* Top-ups cost the same per credit, never a penalty | idem |
| Trial | **14 dagen gratis**, no card details, cancel any time | idem |
| Terms | Geen setup-kosten · maandelijks opzegbaar | idem |
| Time to live | **72 uur** (framed as *"meestal"*, *"afhankelijk van waar je voorraad staat"*) | `meeting.html`, `aanmelden.html` |
| Conversion action | **Plan een demo** — 20 minutes, Google Calendar booking on `meeting.html` | `meeting.html` |
| Contact | `hello@helvaro.pro` · app at `app.helvaro.pro` | footer |
| Company | Belgian. Co-founders: Teljo Crisrosio Kodia (CEO), Sindi Said (CTO) | `waarom.html#team` |

### Which offer do you lead with? The pilot.

Two offers exist in the repo and they belong to different generations. **The pilot is the live one** — it is in the top bar of every single page (*"We zoeken vijf autobedrijven voor de eerste meting."*) and on the homepage, `cases.html` and `automotive.html`, all current generation. The **14-day free trial** lives on `aanmelden.html` and the homepage pricing block; `aanmelden.html` is older-generation copy written around a WhatsApp lead agent.

For content: **lead with the pilot** (five places, six weeks, one measured number, your own figures to keep). Mention the trial only in pricing-specific posts, and never in the same breath as the pilot — they read as two different companies.

### Conversion destinations

| Action | Destination |
|---|---|
| Plan een demo (the main CTA) | `helvaro.pro/meeting.html` — 20 min, a real Google Calendar booking widget |
| See the pilot / the numbers | `helvaro.pro/cases.html` |
| Calculate the leak | `helvaro.pro/roi.html` |
| For car dealers | `helvaro.pro/automotive.html` |
| How it works | `helvaro.pro/systeem.html` · workflows `helvaro.pro/agents/` · integrations `helvaro.pro/koppelingen/` |
| Start the trial | `helvaro.pro/aanmelden.html` → redirects to `app.helvaro.pro/signup` |
| Log in | `app.helvaro.pro` |
| E-mail | `hello@helvaro.pro` |

"Link in bio" on social should point at `helvaro.pro/meeting.html` for a demo CTA, or the relevant deep page for a teaching post.

**The pilot — the most important commercial fact for content.**

Top bar on every page: *"We zoeken vijf autobedrijven voor de eerste meting."*

> *"Helvaro draait, maar we hebben nog geen gemeten resultaat bij een dealer. Dat verzinnen we ook niet. In plaats daarvan zoeken we vijf autobedrijven die het aanzetten op hun aanvragen en ons één cijfer laten meten: hoeveel van die aanvragen een afspraak worden."*

Structure: week 0 nulmeting (2 weeks of counting with nothing switched on) → week 1 one workflow on → weeks 2–5 measure and adjust → week 6 the number. The dealer gets a pilot rate and **their own figures, theirs to keep even if they stop**. Helvaro gets one measurement. *"Valt het tegen, dan schrijven we dat op. Dat is de afspraak."*

---

## 5. VISUAL IDENTITY — "Sand Black"

The house style has a name: **Sand Black** (light mode: Sand White). Warm, minimal, professional. Sand on black. The stated test: *"Zou een garagehouder van vijftig dit vertrouwen met zijn klanten?"*

### Colour tokens (from `css/style.css`, authoritative)

**Dark (default — the site ships dark; light is opt-in)**

```
--accent / accent-fill   #E8D7B1   sand — fills, buttons, icons, accents
--accent-hover           #DDCAA1
--accent-dark / deep     #C9AE7C   deeper sand, second colour in gradients
--accent-light           #F0E4C8   text accents on dark
--bg-0                   #0D0D0D   deeper sections
--bg-1                   #121212   main surface
--bg-2                   #1A1A1A
--bg-card                #232323   cards
--bg-card-hover          #2A2A2A
--border-0               #262626
--border-1               #333333
--text-1                 #F9F9F9
--text-2                 #B5B5B5
--text-3                 #999999
--success #22C55E   --warning #D4A017   --error #DC2626
```

**Light**

```
--bg-1 #FFFFFF  ·  --bg-0/--bg-2 #F7F7F7  ·  cards #FFFFFF with border #E5E7EB
--accent (as text) #B08A4A → --accent-deep #8A6A33
--text-1 #111827  ·  --text-2 #4B5563  ·  --text-3 #6B7280
```

**The contrast rule — never break it.**
> Sand is a *fill* colour, not a text colour. On sand surfaces the text is always dark `#121212`. If you want the accent as text on white, use the deeper bronze `#8A6A33`.

Measured, in the CSS: sand is 1.87:1 on white (fails the 3:1 floor for graphical elements) and 10.02:1 on `#121212`. Bronze is 4.99:1 on white. That is why the bronze logo is the default and the sand logo is used on dark.

### Typography

| Role | Font | Applied spec (what the CSS actually sets) |
|---|---|---|
| Headings `--font-h` | **Bricolage Grotesque** (variable, opsz 12–96, wght 500–700) | `.hero-title` weight **600**, line-height **1.04**, tracking **−0.03em**. `.section-title` weight 600, line-height 1.08, tracking −0.028em. `text-wrap: balance` |
| Special `--font-d` | **Instrument Serif italic**, in sand | **Rare by design.** In the live CSS it is used in exactly three places: `.hero-title .highlight`, `.section-title .highlight` (the second half of the sentence, in colour) and `.pricing-price` (the number only — "/maand" stays Inter). The older style guide also allows pull quotes; the current stylesheet has no such rule |
| Body `--font-b` | **Inter** 400–600 | line-height 1.6–1.7; `tabular-nums` for tables and stats |

The rationale, measured against references on 31-08-2026 and written into the CSS. **Note the table records the state being corrected, not the target** — Helvaro's 700/1.10 was the problem:

```
                Helvaro(before)  Linear   Stripe
  kopgewicht     700             510      300
  regelhoogte    1.10            1.00     1.15
  tracking       -0.028em        -0.022em -0.020em
```

> *"Wat premium leest is niet zwaarder maar lichter: een kop van 700 met strakke tracking wordt dicht en gaat schreeuwen."*

The fix applied was weight 600 and a tighter line-height. That is the spec in the table above. (The comment still reasons about "Space Grotesk 600" — a stale font name from before the Bricolage switch.)

Headlines are short and hard. Body copy is calm and concrete.

### Shape, space, motion

- **Radius** — tokens are `--radius-s/m/l/xl` = **8 / 14 / 22 / 36px**, plus 999px pills. Two hard-coded values override them in the polish layer: **18px** on pricing/solution/booking/signup cards and **12px** on `.btn-lg` (10px on the standard `.btn`)
- **Borders** — 1px, low contrast
- **Shadows** — soft and deep on dark, almost absent on light. Cards: `0 12px 44px rgba(0,0,0,0.45)`
- **Section rhythm** — `clamp(48px, 5.5vw, 76px)` top and bottom → 152px between sections on desktop, 96px on a phone. The comment names the target: *"waar premium SaaS doorgaans op 120 tot 160px zit"*
- **Easing** — `cubic-bezier(0.4, 0, 0.2, 1)`, slow and subtle
- **Hover** — cards lift 3px and the border warms to sand; buttons lift 1px
- **Buttons behave like physical objects**: light top inset, dark bottom inset, and on `:active` the shadow *shrinks* rather than disappearing — *"Een voorwerp dat je indrukt komt dichter bij zijn ondergrond, dus zijn schaduw wordt korter en harder."*
- **Focus** — one ring everywhere: `2px solid var(--accent)`, offset 3px
- **`prefers-reduced-motion` is honoured throughout**

### Photography

There are **two different photo treatments** in the live CSS. Do not conflate them.

| Where | Filter | Reads as |
|---|---|---|
| **Photo cards** (`.photo-img`) | `grayscale(0.45) sepia(0.18) contrast(1.06) brightness(0.95)`, lightening on hover | Warm, partly desaturated, **not** black-and-white. The CSS comment: *"Warme grade zodat stockfoto's bij het sand-palet horen."* |
| **Hero background** (`.hero-bg`, `--hero-img-filter`) | `grayscale(1) sepia(0.28) brightness(0.5) contrast(1.05)` on dark | Fully desaturated, warm, darkened to sit under text |

**Use the photo-card grade as the reference for social imagery**: warm, roughly half-desaturated, slightly darkened. Reserve full greyscale for images that sit *behind* type.

Reality check on the assets: of the five photos in `assets/photos/`, **only `renovation.jpg/.webp` is actually used**, on the three sector pages. `dealer`, `calendar`, `plate-scan` and `reply-first` are unreferenced. **No current-generation automotive page carries a photograph at all** — the homepage hero uses a remote Framer image behind the filter (legacy, and a third-party dependency worth removing). So photography is a *possible* social direction, not something the current site demonstrates.

Subject matter, when you do use photography: real forecourts, real cars, real workshops. Never staged smiles, never open-plan office stock.

### Logo

**Every page uses one file: `assets/logo-wordmark.png`** — the gold "HELVARO" wordmark with the circular compass mark (ring, up arrow, right arrow), taken from the app. It is placed by `tools/shell/nav.html` and `tools/shell/footer.html`, so it is identical everywhere.

The sand appearance is **produced by CSS, not by a separate file.** The wordmark is gold; the stylesheet filters it per theme:

```
dark   .nav-logo img, .footer-logo, .nf-logo  filter: saturate(0.74) contrast(0.42) brightness(1.47)
light  same selectors                          filter: saturate(1.25) contrast(0.90) brightness(0.83)
```

The light-theme target named in the CSS is bronze **`#B08A4A`** — the same colour as the button border and accent text there — because pale sand on white measures about 1.3:1.

`logo-sand@2x.png`, `logo-brons@2x.png` and `logo-mark.png` still sit in `assets/` but **are referenced by no HTML, CSS or JS.** They are leftovers from the previous logo system. Do not treat them as the current mark, and do not follow older guidance about "bronze on light, sand on dark" as separate files.

Rules: never redraw the wordmark, never recolour it by hand, never place it on a background that kills the gold. If you need it to read as sand, that is what the dark-theme filter is for.

### Status pills — a signature component

One shape for all three states, because telling them apart is the point:

`live` → green `#22C55E` · `in ontwikkeling` → amber `#D4A017` · `gepland` → grey `--text-3`
Pill: 999px radius, 1px border, 11px semi-bold, with a 6px dot in `currentColor`.

---

## 6. DESIGN PHILOSOPHY — why it looks like this

Derived from the rationale comments written into `css/style.css`. These are real decisions, not retrofitted theory.

**1. It removes the things that signal "AI startup template."**
A film-grain overlay and a custom mouse cursor were built and then deliberately disabled:
> *"Een filmkorrel-overlay over de hele pagina en een zelfgemaakte muiscursor zijn typische 'AI-startup template'-signalen. Ze voegen niets toe, kosten rendertijd... Voor een B2B-product dat serieus genomen wil worden: eruit."*

**2. It avoids the blue/purple AI aesthetic entirely.** The banned list is explicit: *"Paars, indigo, blauwe verlopen, neon, glasmorfisme."* Sand-on-black reads as tooling and money, not as software.

**3. Premium is achieved by taking weight off, not adding it.** Lighter headline weight, tighter tracking, tighter line-height, more air between sections.

**4. Technology is shown as product, not as illustration.** The dashboard, the phone, the chat and the dossier are **rebuilt in HTML/CSS**, not pasted in as screenshots — so they stay sharp at any size and contain no real customer data. The comment on the dashboard mock: *"Alle namen en cijfers zijn verzonnen."*

**5. Motion is information, never decoration.** Two rules, written for Faro but applied everywhere:
> *"Wat BLIJFT DUREN beweegt zacht en traag. Wat een GEBEURTENIS is speelt EEN keer af en stopt."*
> *"Juichen dat blijft juichen viert niets meer; trillen dat blijft trillen leest als een kapotte pagina."*
No scroll-jacking, no pinned sections, no animation you must sit through.

**6. Trust is communicated by subtraction.** The most persuasive pages are the ones listing what Helvaro does *not* do: the anti-ICP block, the "Grenzen" section on every agent page, "Wat we niet zeggen" on `cases.html`, the six control commitments. *"Deze lijst kost ons waarschijnlijk klanten. Hij levert er ook betere op."*

**7. Curiosity comes from tension, not from teasing.** Every major heading is a pair where the second half undercuts the first. That is the engine of the whole voice — see §9.

**8. Clutter is avoided by one treatment per element type.** One card treatment, one section rhythm, one focus ring, one status pill. Divergence is treated as a bug and logged in the CSS.

---

## 7. THE WEBSITE → CONTENT CONNECTION

What the site communicates, and how social content should reinforce it:

| The site says | Social content reinforces it by |
|---|---|
| Speed of first response decides the sale | Telling one concrete 21:43 story, not by claiming "fast AI" |
| One conversation across three channels | Showing a buyer who starts on the site, WhatsApps at night and mails a photo — one dossier |
| The system knows *your* stock | Dramatising the moment it says "dat staat niet in de gegevens" instead of inventing |
| The human keeps the margin conversation | Making the handover the hero, not the automation |
| Honesty about what is built | Publishing a limit as content, not hiding it |
| Premium tooling, not toy software | Restrained visuals, one idea, generous whitespace |

**Never simply restate website copy in a post.** Take the underlying situation and retell it from the operator's chair.

---

## 8. FARO — THE MASCOT (read carefully)

> ### ⚠️ CORRECTION TO A COMMON BRIEF
> Faro is **not** an orange/terracotta geometric character with black eyes on a white background. That description does not match any asset, any page or any CSS rule in this repository, and following it would produce off-brand work.
> **Faro is a young falcon.** If a brief tells you otherwise, this file and the assets in `assets/faro/` take precedence — then flag the discrepancy to the user.

### What Faro actually is

**Positioning first.** From `faro.html`: *"Het gezicht van het systeem. Niet het systeem zelf."*
> *"Helvaro is wat je koopt. Faro is hoe je het bedient: de plek waar je meeleest, overneemt en in gewone taal vraagt wat er met een koper gebeurd is."*

Faro's own line: *"Dit ben ik. Ik ben niet het product, maar de laag waarin je meeleest, overneemt en vragen stelt."*

What Faro does, per `faro.html`: one overview of everything running · everything awaiting approval in one list with the reason · shared memory (*"Een correctie die je één keer maakt, geldt daarna voor elke werkstroom"*) · plain-language questions (*"welke koper staat het dichtst bij een handtekening"*).

### Appearance (verified against the actual image files)

- **Species/form:** a stylised young falcon — chunky, rounded, upright, big head, short legs. Soft 3D render, matte finish, toy-like but not childish.
- **Two colourways — but only for the two large hero renders:**
  - `faro-donker.png/.webp` (840×840) — **matte black** plumage, shown on the dark theme
  - `faro-wit.png/.webp` (840×840) — **matte white/off-white** plumage, shown on the light theme
  - The theme swap is a CSS rule that applies **only to this pair**, on `faro.html`.
  - ⚠️ **The six pose renders in `assets/faro/` exist in black only** and are served unchanged on both themes. `404.html` uses the white hero render regardless of theme. So if you brief "white falcon, thinking pose", **no such asset exists** — either use the black poses, or commission the white set.
- **Gold/bronze accents on both:** eye rings, beak, talons, wing trim, a thin collar line, and a **shield-shaped chest crest carrying the Helvaro compass mark**.
- **Eyes:** large, glossy, near-black, with a single white specular highlight. Expressive. Not screens, not glowing, not LEDs.
- **Background:** transparent PNG/WebP. On the site he is placed either free on the page or on a soft panel with a warm radial glow behind him (`--accent-glow`), never in a frame or a card: *"Geen kaartje met een vogeltje erin. De valk staat VRIJ op de pagina."*

### The six poses (`assets/faro/`)

| File | State | Reads as |
|---|---|---|
| `falcon-idle.webp` | wachten | calm, one wing raised in a small wave |
| `falcon-thinking.webp` | denkt | wing to beak, brow lowered, considering |
| `falcon-generating.webp` | bezig/werkt | wing raised, mid-action |
| `falcon-success.webp` | klaar | both wings up, beak open, celebrating |
| `falcon-error.webp` | fout | wings down, flat, apologetic |
| `falcon-video.webp` | — | eyes closed, both wings spread wide · **currently unreferenced by any page or script** |

**The expression rule:** *"Een uitdrukking is hier een TEKENING PLUS EEN BEWEGING."* Six drawings across eleven moods. On the current site the site-wide animations were removed on request; the **pose still changes per section, and that is the information.**

### Personality

Set by the `stem` (voice) values in `js/main.js`: `denkt, wijst, ernstig, legt uit, speurt, toont, nuchter, rustig, eerlijk, werkt, port, trots, nieuwsgierig, open, rekent, juicht`.

Faro is **sober, observant, slightly dry, never cute, never salesy**. He speaks in **one short sentence**. He is honest about limits before he is proud of features. Examples of his actual voice:

- *"Dit is het probleem in één zin: de aanvragen komen al binnen, alleen antwoordt er niemand op tijd."*
- *"Een chatbot doet laag drie en stopt daar. Wij doen ze alle vijf."*
- *"Dit scherm is een voorbeeld, geen klantcijfer."*
- *"Belgisch bedrijf, verwerking binnen de EU. Geen doorverkoper met een Amerikaans dashboard."*
- *"We hebben nog geen gemeten resultaat, en we verzinnen er ook geen. Daarom deze pilot."*
- *"Een gesprek dat stilvalt is geen afwijzing. Het is werk dat je al betaald hebt."*

### Rules for using Faro

**Do**
- Keep the black version on dark backgrounds, the white version on light.
- Give him a warm sand glow so he does not read as a hole in the page.
- Let him *do something* — a pose that matches the situation in the content.
- Keep the gold chest crest, gold eye rings, gold beak and talons.
- Keep him dismissible in any interface context (*"Iets dat meescrollt en niet weg kan is geen gids maar een banner"*).

**Never**
- Never redesign him, recolour him, or change the species.
- Never make him a generic robot, a humanoid AI assistant or a chat bubble avatar.
- Never put him in blue/purple, neon, or a gradient.
- Never give him a mouth full of text, a speech bubble crammed with copy, or a logo repeated around him.
- Never let him hijack the page.
- Never present Faro as *the product*. He is the layer you operate it through.

---

## 9. BRAND PERSONALITY AND VOICE

### It should feel

Intelligent · direct · modern · practical · premium · calm · human · outcome-focused · slightly provocative when the situation earns it.

### It should not feel

Corporate · fake-professional · over-polished · hype-driven · "AI bro" · generic SaaS · buzzword-laden · like an AI-generated marketing agency · like a chatbot company claiming a revolution.

**The difference, concretely:**

| Generic SaaS says | Helvaro says |
|---|---|
| "Empower your sales team with AI" | "Je hebt geen tekort aan leads. Je hebt een aanvraagprobleem." |
| "Transform your customer experience" | "Wie als eerste antwoordt, verkoopt." |
| "Leverage automation to scale" | "Een koper die wachtte, wacht niet lang." |
| "Our AI assistant handles enquiries" | "Een chatbot kent je openingsuren. Dit kent je voorraad." |
| "Trusted by industry leaders" | "We hebben nog geen resultaat om te laten zien. Dus laten we er geen zien." |

### The signature sentence shape: the tension pair

Two short sentences where **the second undercuts or reframes the first.**

Live on the current site:

- "Elke voertuigaanvraag. Afgehandeld."
- "Je hebt geen tekort aan leads. Je hebt een aanvraagprobleem."
- "Bestaat wel, leeft niet."
- "Ander kanaal. Zelfde systeem."
- "Stilte is geen nee."
- "Automatisch waar het kan. Een mens waar het moet."
- "Verkocht is verkocht."
- "Waar een chatbot stopt, begint de rest."
- "Het gezicht van het systeem. Niet het systeem zelf."
- "Geen chatbot op je website. Het systeem dat je aanvragen omzet in afspraken."

From the older style guide, still good models but **not currently on the site** — use as shape references, do not quote as brand copy: *"Je bedrijf groeit. Je werkdruk niet."* · *"Geen chatbot die vragen beantwoordt. Een systeem dat afspraken oplevert."*

This shape carries headlines, post hooks and image captions. It is the most recognisable thing the brand owns in language.

### Mechanics (house rules, enforced on the site)

- **No exclamation marks.**
- **No superlatives.**
- **No em dashes or en dashes inside sentences.** Use a comma, a full stop, or a middle dot `·`. (The rule is written in the older style guide, but the current pages follow it consistently — the middle dot is everywhere, the em dash nowhere in body copy.)
- Numbers: Belgian formatting — `€ 48.900`, `82.000 km`, `8,6`. In FR/DE/ES: `280 k€`. In EN: `8.6`.
- Never call it "de AI". Name the system or the workflow.
- Headlines short and hard; body calm and concrete.
- Prefer a real time of day, a real car, a real amount over an abstraction.

---

## 10. LANGUAGE POLICY

The site ships in **five languages**: Dutch (source), French, English, German, Spanish. Dutch lives in the repo root; `/fr/`, `/en/`, `/de/`, `/es/` are generated by `tools/build-langs.pl` from `js/lang/*.js`.

**Formality is set per language and is consistent across the whole site** (verified by counting across the dictionaries):

| Language | Address | Evidence |
|---|---|---|
| **Nederlands** | informal **je / jij / jouw** | site-wide (older legal boilerplate in `privacybeleid.html` still uses *u*) |
| **Français** | formal **vous** | ~700 occurrences of `vous`; informal forms essentially absent |
| **Deutsch** | formal **Sie / Ihr** | ~640 `Sie` plus ~450 declined `Ihre/Ihren/…`; **zero** `du` |
| **English** | neutral **you** | — |
| **Español** | **informal**, second person singular | ~557 `tu/tus`; **zero** `usted`. Note the pronoun `tú` itself is never written — it is the verb forms and possessives that carry it ("Hablas con un agente de IA", "tus leads") |

Localisation is **transcreation, not translation.** The hero line proves the standard:

```
NL  Elke voertuigaanvraag. Afgehandeld.
FR  Chaque demande de véhicule. Traitée.
EN  Every vehicle enquiry. Handled.
DE  Jede Fahrzeuganfrage. Bearbeitet.
ES  Cada consulta de vehículo. Atendida.
```

Every version keeps the two-part tension shape and the full stop in the middle. That is the bar.

**Rules:**
- Never translate a Dutch idiom literally. Rebuild the tension pair in the target language.
- Localise numbers, currency position and decimal separators.
- Belgian French, not Parisian. Flemish Dutch, not Netherlands Dutch (`nummerplaat`, not `kenteken`).
- The product claim is that the agent **recognises the buyer's language and continues in it** — Dutch, French, English, German are the ones named on `automotive.html`. "Spreekt 40 talen" appears in the pricing feature list (Growth and up) and in the `controle.html` trust ticker; treat it as a plan feature, not a headline claim.
- One sentence the brand owns: *"Nederlands en Frans in één gesprek."* For cross-border dealers: *"scheelt dat een halve verkoper."*

---

## 11. CONTENT PRINCIPLES

**The founding principle:**

> Content starts from the operational problem, never from the technology.
>
> ❌ "AI is transforming how businesses handle customers."
> ✅ "A buyer does not care that your salesperson was with a customer. He cares whether someone answered."

**The eight principles:**

1. **One post, one idea.** If it needs two, it is two posts.
2. **Be specific to the point of discomfort.** Not "leads go cold" but "fourteen conversations from last week that are on nobody's list."
3. **A time of day beats an adjective.** 21:43, 23:40, 17:50, "kwart voor tien 's avonds".
4. **Write from inside the business.** The reader should think *"who told you about my Thursday?"*
5. **The problem is never the reader's team.** It is timing, volume and process. *"Het probleem is niet jouw team. Het is timing."* Never condescend to salespeople.
6. **Limits are content.** What the system refuses to do is more persuasive than another benefit.
7. **No number you cannot source.** See §16.
8. **Helvaro sits behind the thinking.** Most posts should be useful even if Helvaro did not exist.

**Approved subject matter:** slow replies · leads arriving outside working hours · weak follow-up · repetitive conversations · manual qualification · appointment scheduling · staff time lost to typing the same five answers · deals going quiet · missed opportunities · operational bottlenecks · handling more volume without hiring · response speed · customer experience · trade-in and financing friction · the handover between system and human · what a system should *not* be allowed to do.

---

## 12. POST WRITING RULES (LinkedIn / Instagram)

### Default structure

**Hook → situation → insight → practical conclusion**

Use it, but do not force it. A single sharp observation with no structure at all is often stronger.

- **Hook** — one line, concrete, ideally a tension pair or a time stamp. No throat-clearing.
- **Situation** — a real moment in a real business. Names, times, cars, amounts.
- **Insight** — the reframe. Why the obvious fix (work harder, hire someone, reply faster) does not solve it.
- **Conclusion** — a thought the reader can act on, or a genuine question. Not a CTA by default.

### Length and shape

- Short. 60–150 words for most posts.
- Short paragraphs, mostly one or two sentences, with white space between them.
- No emoji as decoration. The only acceptable use is inside a quoted chat message, where a real buyer would have typed one (the site's own mocks do this: "10:00 graag 👍").
- No hashtag walls. If any, two or three, lowercase, specific.
- End strong. The last line is the one that gets screenshotted.

### CTA policy

Rotate; do not end every post the same way. Levels, weakest to strongest:

1. No CTA at all *(the default for teaching posts)*
2. "Herkenbaar?"
3. A real question the reader can answer from their own business
4. "Bekijk hoe het werkt" / link in bio
5. "Plan een demo van twintig minuten"

Roughly: of any five posts, at most one should carry a level-4 or level-5 CTA.

### Avoid

Generic motivational language · "The future is here" · "AI is changing everything" · "In today's fast-paced world" · invented statistics · empty claims · corporate jargon · emoji clutter · overexplaining · hard selling · a forced CTA on every post · making every post about Helvaro.

---

## 13. WHEN TO MENTION HELVARO

**The default arc:** teach → show you understand the operation → create curiosity → *optionally* connect it to what we are building.
**Not:** problem → immediate pitch.

Natural connective phrasing (use sparingly, vary it):

- "Het is een van de dingen waar we het systeem omheen bouwen."
- "Dat is precies het soort werkstroom waar we aan werken."
- "Hier komt Helvaro in beeld."
- "We bouwen systemen rond dit probleem."

**Rules**
- Mention Helvaro only when it adds information the reader would miss otherwise.
- Never turn a post into an advertisement.
- If the post would be weaker without the product mention, keep it. If it would be *stronger* without it, cut it.
- Product posts (pricing, pilot, a specific workflow) are legitimate — just keep them to a minority of the feed.

---

## 14. CONTENT PILLARS

### 1. Response speed decides the sale

**Covers:** the first ten minutes after an enquiry; evenings, weekends, after hours; the buyer who asked three dealers.
**Why it matters:** it is the brand's central claim and the only thing the pilot measures.
**Example topics:** the 21:43 enquiry read at 09:15 · why calling back at 17:30 is too late · the busiest two hours of a dealer website are after closing time · "wie als eerste antwoordt, verkoopt".
**Helvaro connection:** natural and strong — but usually only in the last line.
**Avoid:** any specific speed number presented as a measured result (see §16 and §20.1).

### 2. Leads you already paid for

**Covers:** follow-up, conversations that went quiet, old quotes, existing customers.
**Why it matters:** the cheapest margin in the business, and the thing nobody has time for.
**Example topics:** fourteen conversations on nobody's list · "ik denk er nog over na" is not a no · why follow-up dies (it is never urgent) · stopping after three messages instead of nagging.
**Helvaro connection:** the Opvolging werkstroom; three touches then stop.
**Avoid:** anything that sounds like automated nagging or spam.

### 3. The system knows your stock

**Covers:** answering with real vehicle data; refusing to invent; sold is sold.
**Why it matters:** it is the concrete difference between a chatbot and this.
**Example topics:** "Heeft die X5 een trekhaak?" and the honest "dat staat niet in de gegevens" · why a general assistant asks general questions · xDrive is not quattro · showing three alternatives instead of thirty.
**Helvaro connection:** direct and comfortable — this is the product.
**Avoid:** implying integration with any stock system that is not live (§2).

### 4. Automatic where it can be, human where it must be

**Covers:** handover, negotiation, trade-in values, complaints.
**Why it matters:** it defuses the biggest objection and respects the salesperson.
**Example topics:** the moment a salesperson steps into a live conversation and the buyer notices nothing · why a trade-in figure must come from a person · the internal shorthand "ja nog beschikbaar, zaterdag 14u kan" becoming a proper reply · a system that gives away margin cannot take it back.
**Helvaro connection:** strong.
**Avoid:** any suggestion that Helvaro replaces salespeople (§20.2).

### 5. Control, transparency and what it is not allowed to do

**Covers:** approval per action type, the log, the kill switch, EU data, the AI Act.
**Why it matters:** it is the buyer's real fear, and Helvaro has unusually good answers.
**Example topics:** the six commitments · "een prijs noemen is iets anders dan een proefrit vastzetten" · why every conversation stays readable in full and not as a summary · why the agent says it is an AI in the first message.
**Helvaro connection:** natural.
**Avoid:** claiming perfection. The brand explicitly does not claim errors never happen.

### 6. Honest measurement (and the pilot)

**Covers:** why there are no percentages on the site; what will be measured; what a real case study must contain.
**Why it matters:** it is the brand's sharpest differentiator in a category full of invented numbers.
**Example topics:** "we hebben nog geen resultaat om te laten zien, dus laten we er geen zien" · the six things a case study needs or it is just a testimonial · one ratio measured the same way before and after · live vs in ontwikkeling vs gepland.
**Helvaro connection:** the pilot, five places.
**Avoid:** softening it. This pillar only works if it stays blunt.

### 7. One buyer, one car, one dossier

**Covers:** channel switching, context that survives, the shared mailbox.
**Why it matters:** it is the structural argument for a system over a stack of tools.
**Example topics:** he starts on the site, WhatsApps at night, mails a photo of his trade-in · "Hallo, waarmee kan ik je helpen?" at every new channel · eight subscriptions, eight inboxes, zero overview · WhatsApp on one salesperson's private phone is not a company asset.
**Helvaro connection:** strong.
**Avoid:** technical integration language.

### 8. Growing without hiring

**Covers:** capacity, repetitive work, what a salesperson should actually be doing.
**Why it matters:** it is the economic argument, and it must be made carefully.
**Example topics:** your best salesperson typing the same five answers thirty times a week · what happens to enquiry volume when the ads work but the handling does not · the difference between more conversations and more appointments.
**Helvaro connection:** possible, but keep it modest.
**Avoid:** "replace a headcount" framing and any salary comparison (§20.2).

---

## 15. CONCEPTS HELVARO SHOULD OWN

Only concepts the product actually supports:

1. **Never letting an enquiry wait** — including evenings and weekends.
2. **The first ten minutes decide the sale.**
3. **Answering with your own stock, never inventing** — "dat staat niet in de gegevens" as a feature.
4. **Automatic where it can be, human where it must be.**
5. **One buyer, one car, one dossier across three channels.**
6. **Follow-up that ends in a yes or a no** — then stops.
7. **Approval per action type**, not one on/off switch.
8. **Saying live only when it is live.**
9. **Turning inbound conversations into booked appointments** — the only number the pilot measures.
10. **Margin conversations stay with the salesperson.**

Do **not** try to own: voice/telephony, CRM, lead generation, advertising, pricing/negotiation, vehicle valuation, "replacing staff".

---

## 16. CLAIMS AND ACCURACY

### The hard rule

> If a number is not documented in this file or in the repository, it does not go in the content. Not as a rounded figure, not as "up to", not as a hypothetical example that reads like a result.

### Never invent

Customer results · revenue figures · conversion rates · response statistics · case studies · customer names · testimonials · product capabilities · integrations · performance numbers · logos.

The site itself commits to this in public (`cases.html`), which means breaking it is not just sloppy, it is a contradiction of the brand:

> *"Op de meeste sites van dit type staan percentages zonder bron en tevreden klanten zonder achternaam. Wij hebben die niet."*

**Wat we niet zeggen** (verbatim, from `cases.html`):
- Dat we je omzet met een bepaald percentage verhogen
- Dat er nooit een fout gemaakt wordt
- Dat een koppeling af is voor hij bij een autobedrijf werkt
- Dat we al autobedrijven als klant hebben die we mogen noemen
- Dat dit voor elk autobedrijf past

### Classify every statement before publishing

| Class | Definition | How to phrase it |
|---|---|---|
| **Product capability** | Something the system does today, LIVE in §2 | State it plainly |
| **Marketing positioning** | A framing or point of view | State it as a view, not a fact |
| **Internal belief** | What we think is true but have not measured | "We denken", "onze aanname" |
| **Example / illustration** | A constructed scenario | Label it: "voorbeeld", "voorbeeldweergave" |
| **Customer result** | Measured at a real customer | **None exist yet. Do not write one.** |
| **Hypothesis** | What the pilot will test | "dat is wat we gaan meten" |

### Numbers you may use, and how

| Number | Use it as | Never |
|---|---|---|
| €249,99 / €499 / vanaf €799 per maand | Fact | — |
| 14 dagen gratis, geen kaartgegevens | Fact | — |
| 1 gesprek ≈ 20 credits | Fact | — |
| 72 uur live | "meestal", "afhankelijk van je setup" | A guarantee |
| 40–300 wagens, 2–8 verkopers | ICP definition | A customer statistic |
| Vijf pilotplaatsen, één cijfer, zes weken | Fact | — |
| 8 werkstromen, 5 lagen, 3 kanalen, 6 controle-afspraken | Fact | — |
| Response speed | **Use the behaviour, not the number:** "meteen", "terwijl het gesprek nog loopt", "ook om kwart voor tien 's avonds" | "Binnen 30 seconden" as a proven stat — the repo states four different values (§20.1) |
| "7× meer leads" (HBR Lead Response Management Study) | Only with the source named, and only as external research | As a Helvaro result |
| Anything from the ROI calculator | An estimate the reader generated themselves | A Helvaro claim |

**What the ROI calculator actually is** (`roi.html`): five inputs — aantal verkopers (default 3), onbeantwoorde aanvragen per week (12), brutomarge per verkochte auto (€1.800), conversie (8%), hoeveel een systeem ervan opvangt (60%, labelled *"Onze eigen aanname… Zet hem lager als je sceptisch bent, dat mag."*). Formula: *onbeantwoorde aanvragen per week × 4,33 weken × conversie × brutomarge*. With the defaults it shows €7.482 per month and €89.787 per year. Those are **defaults in a calculator, not findings** — never quote them as what Helvaro delivers. The page also lists what it deliberately leaves out: missed trade-ins, dead financing questions, unconfirmed test drives, buyers who dropped at the third question.

The ROI calculator's own disclaimer sets the standard: *"Dit is een schatting, geen belofte... Gebruik het om een orde van grootte te zien, niet om een businesscase op te bouwen."*

### What a real case study will require (all six, or it is not a case)

Situation · nulmeting · what was switched on · the result by the same method · what it produced in euros where honest · the owner by name, photographed on his own lot, in his own words.
*"Ontbreekt een van deze zes, dan is het geen case maar een aanbeveling."*

---

## 17. COMPETITIVE POSITIONING

Compete on the **workflow you own**, never by attacking a named competitor.

**The three things people compare Helvaro to, and the honest answer:**

| Alternative | The real difference |
|---|---|
| **A chatbot on the website** | It does layer three and stops. It knows your opening hours; it does not know your stock, it does not own the calendar, and after the conversation nothing has changed in your schedule. |
| **A standalone tool / a ChatGPT + Zapier flow** | One task, no memory between conversations, nothing lands in the calendar. *"Voert één taak uit. Weet niets van het gesprek van gisteren."* |
| **Hiring another salesperson** | A person cannot answer at 23:40 on a Sunday, and does not need to. The system takes the repetitive part so the person does the part with margin in it. **Never frame this as replacing a headcount.** |

**Where humans remain essential — say this out loud:**
negotiation · trade-in valuation · complaints and damage · the closing conversation · anything the owner wants approved.

*"Het neemt het herhaalwerk over: de eerste vragen, het uitvragen, het inplannen en het opvolgen. De gesprekken waar het geld in zit, blijven bij je verkopers. Het verschil is dat ze die voeren met iemand die al weet welke wagen hij wil en wanneer hij kan komen."*

Also ownable, quietly: **Belgian company, EU processing, bilingual by default.** *"Geen doorverkoper met een Amerikaans dashboard."* Never say a competitor is illegal or unsafe.

---

## 18. VISUAL CONTENT RULES

### Format

> These social dimensions are **our own production convention**, established in the Helvaro social batches (`OneDrive\Documents\Helvaro\Social`). They are not specified anywhere in the website repo — the only image sizes there are the 1200×630 OG card and the 840×840 Faro renders. Treat them as the house standard for social, not as a repo-derived fact.

- Social: **1080×1350 (4:5)**. Readable at profile-grid size (~123px tile). Text at least 90px from every edge so the 3:4 grid crop never touches it.
- Dark by default: `#121212` background, sand `#E8D7B1` accents, `#F9F9F9` text, `#232323` cards with `#333333` borders.
- Headline in Bricolage Grotesque-like weight 600, tight tracking. Body in Inter. Instrument Serif italic **only** for a highlighted half-sentence, a pull quote or a price.

### Preferred visual approaches

1. **Type-only.** Sand kicker, large headline, one supporting line, logo, hairline, `helvaro.pro`. Most reliable, most on-brand.
2. **Workshop/forecourt photography**, black-and-white and warm-graded, with a dark gradient behind the text. Real places, real cars.
3. **Product/UI rebuilt as graphics** — a dossier, a chat, a status list, a two-by-two of numbers. Always labelled "Voorbeeldweergave" when it shows figures.
4. **Faro**, doing something that matches the idea.

### Faro in visuals

Black falcon on dark, white falcon on light. Gold eye rings, beak, talons, chest crest. Soft 3D, matte, transparent background, subtle shadow, warm sand glow behind him. One clear situation, generous whitespace, restrained colour, editorial calm.

Each Faro visual should show him **experiencing or resolving the situation the content is about** — waiting by a silent phone at 21:43, pointing at a dossier, standing between a buyer and a calendar. Not posing next to a logo.

### Never

Text-heavy graphics · infographics unless asked · dashboards as wallpaper · logos scattered around · **blue or purple AI gradients** · neon · glassmorphism · generic humanoid robots · brains, neural networks, glowing chips · stock-photo smiles and open-plan offices · busy 3D scenes · clip art · anything that reads as a default SaaS template.

The house-style prompt states the ban directly: *"Paars, indigo, blauwe verlopen, neon, glasmorfisme... hersenen, robots, netwerken van bolletjes, gloeiende chips."*

### The test

> *"Zou een garagehouder van vijftig dit vertrouwen met zijn klanten? Zo niet, dan is het te speels. Ziet het eruit als elke andere AI-startup? Dan is het te generiek."*

---

## 19. QUALITY CHECKLIST

Run this before delivering any post.

**Substance**
- [ ] One clear idea?
- [ ] Is the problem concrete — a time, a car, an amount, a moment?
- [ ] Would a dealer principal recognise their own week in it?
- [ ] Is it useful even if Helvaro did not exist?

**Voice**
- [ ] Does the hook land in one line, with no throat-clearing?
- [ ] Does it sound like an operator wrote it, not a marketing department?
- [ ] Any jargon, buzzwords or motivational filler to cut?
- [ ] Any em dashes, exclamation marks or superlatives? (Remove.)
- [ ] Is the last line strong enough to screenshot?

**Truth**
- [ ] Is every number sourced from §16?
- [ ] Is every capability LIVE in §2, or explicitly labelled otherwise?
- [ ] Any implied customer result? (There are none.)
- [ ] Any example figure that could be mistaken for a measured one? Label it.

**Product**
- [ ] Is Helvaro being forced in? Cut it.
- [ ] Is the CTA level right, and different from the last few posts?
- [ ] Does it respect salespeople rather than replace them?

**Distinctiveness**
- [ ] Could a competitor publish this unchanged? If yes, it is too generic.
- [ ] Does it sound like AI-written LinkedIn content? Rewrite.

---

## 20. KNOWN CONTRADICTIONS IN THE REPO

The site currently carries **two generations of copy**. The automotive generation is current; the older generic "leads / drie agents / WhatsApp-first" generation still survives on some pages. **When they conflict, the automotive generation wins.**

Current-generation (trust these): `index.html`, `automotive.html`, `systeem.html`, `controle.html`, `cases.html`, `roi.html`, `faro.html`, `agents/*`, `koppelingen/*`, `meeting.html`, `tools/shell/nav.html`, `tools/shell/footer.html`.
Older-generation (do not source content from these without checking): `waarom.html`, `contact.html`, `aanmelden.html`, `sectoren/*`, `assets/og-card.png`, `HUISSTIJL-PROMPT.md`.

**20.1 — Response time has four different values.** "&lt; 30 sec" (`aanmelden.html`), "Binnen 30 seconden" (`contact.html`, `index.html` pricing), "binnen dertig seconden" (`sectoren/vastgoed.html`), "Binnen een minuut" (`meeting.html`, current generation).
→ **In content, describe the behaviour, not the number.**

**20.2 — "Does it replace a salesperson?" is answered both ways.** `contact.html` FAQ says *"Ja... Dit vermindert de nood aan extra personeel."* `automotive.html` and `meeting.html` say *"Geen vervanging van je verkopers"* / *"Nee."*
→ **Use "Nee."** It is the current position and the better one.

**20.3 — E-mail is sold as a channel but marked in ontwikkeling.** The homepage, `automotive.html`, `meeting.html` and `agents/e-mail.html` present e-mail as part of the offering; `koppelingen/index.html` and `systeem.html` mark it *in ontwikkeling — "staat nog niet bij een klant"*.
→ **Treat e-mail as in ontwikkeling.** Lead with website and WhatsApp.

**20.4 — ICP is stated narrowly and broadly.** `contact.html`/`waarom.html` FAQ still list *"verzekeringen, recruitment, automotive, B2B SaaS, vastgoed, renovatie, zorgpraktijken, advocaten, coaching en meer"*.
→ **Use the narrow automotive ICP** from §3.

**20.5 — Language coverage is stated as 2, 4 and 40.**
→ Use *"Nederlands, Frans, Engels, Duits"* for capability; treat "40 talen" as a plan feature only.

**20.6 — Other drift, lower stakes.**
- `assets/og-card.png` still shows the old light-theme card *"Elke lead een antwoord. Binnen 30 seconden."* while `og:title`/`og:description` are current. Do not reuse that image as a brand reference.
- Agent pages say *"Agent NN van tien"* while there are eight werkstromen.
- `systeem.html`'s `<title>`/meta still mention *werkplaatsafspraak / werkplaatsplanning*; the body is entirely sales-side.
- `cases.html` says both "Vier weken" and "Zes weken" (Week 0 → Week 6).
- `roi.html` says "Vier cijfers" but has five inputs, and one input id is still `rek-monteurs`.
- `contact.html`'s form has an empty `data-endpoint` and only opens the visitor's mail client.
- `HUISSTIJL-PROMPT.md` still describes the audience as *"onafhankelijke garages en werkplaatsen"* with APK and kenteken, and mentions telephone as a channel. **Its colour guidance and its tone-of-voice guidance are still correct. Its audience, channel, logo, radius and spacing guidance are not** — it gives radii as 8/14/22 only and section spacing as "72 tot 100px", against the live `clamp(48px, 5.5vw, 76px)`. Use §5 of this file over it.
- The homepage hero background is a **remote image hosted on `framerusercontent.com`**, desaturated by CSS. It is a legacy third-party dependency, not a brand asset.
- The Helvaro application itself (`app.helvaro.pro`, referenced in CSS as `api/dashboard.js` and `api/_faro/ui/styles.js`) **is not in this repository.** Do not make claims about app behaviour that the website does not state.

---

## 21. SOURCE OF TRUTH PRIORITY

When sources disagree, resolve in this order:

1. **The current production implementation** (the live app at `app.helvaro.pro`)
2. **The current website** — the Dutch source pages in the repo root, current generation (§20)
3. **Current product functionality** — the capability ledger in §2
4. **Current approved Helvaro positioning** — automotive-first, system not chatbot
5. **This file**
6. **Older documentation** — `HUISSTIJL-PROMPT.md`, `waarom.html`, older social batches, `tools/README.md`
7. **Assumptions** — never

**On a contradiction, investigate. Do not guess, and do not average two sources.** Read the page in the repo, check the status pill, then write. If it cannot be resolved, ask the user and say which two sources disagree.

---

## 22. CALIBRATION EXAMPLES

These demonstrate the principles. **Do not reuse them as templates** — they will go stale and they will be recognisable if repeated.

### ✅ A good Helvaro post

> Om 23:40 vroeg iemand of de Passat er nog stond.
>
> De mail werd om 07:20 gelezen, onder zes andere.
>
> Tegen die tijd had hij dezelfde vraag bij twee andere bedrijven gesteld. Bij één daarvan kreeg hij binnen het uur antwoord.
>
> Dat is geen leadprobleem. De belangstelling was er, om 23:40, van iemand die precies wist welke wagen hij bedoelde.
>
> Het gat zit tussen het moment waarop hij het vraagt en het moment waarop iemand tijd heeft om te antwoorden.
>
> Hoe laat komt de laatste aanvraag bij jullie binnen?

**Why it works:** a time stamp instead of an adjective; a situation a dealer recognises; the reframe ("dat is geen leadprobleem"); no product mention; a question that can actually be answered.

### ❌ A bad Helvaro post

> 🚀 AI is revolutionizing the automotive industry!
>
> Did you know that 78% of leads go to whoever responds first? In today's fast-paced digital world, dealerships can't afford to be slow.
>
> That's why we built Helvaro — the AI-powered assistant that transforms your lead management and boosts conversions by up to 40%. ✨
>
> Our cutting-edge technology handles everything automatically so your team can focus on what matters.
>
> Ready to revolutionize your dealership? DM us today! 🔥👇

**Why it fails:** invented statistics with no source; "revolutionizing"; "in today's fast-paced world"; "AI-powered"; an unverifiable performance claim; emoji clutter; a hard CTA; and it says "handles everything automatically", which contradicts the product's own limits.

### ✅ A good visual concept

*Post: the 23:40 enquiry.*
1080×1350, background `#121212`. Top left, the sand Helvaro mark. Sand kicker "NA SLUITINGSTIJD". Headline in large tight type: **"23:40. Hij vraagt het ook aan twee anderen."** One `#B5B5B5` line underneath: "Wie als eerste antwoordt, verkoopt." Bottom: hairline in `#333333`, then `helvaro.pro`. Nothing else.
*Alternative:* the black Faro in the `thinking` pose, standing free on the dark page beside a single glowing phone notification, generous empty space around him.

**Why it works:** one idea, readable at grid size, on-palette, no logo repetition, no invented dashboard, Faro doing something that means something.

### ❌ A bad visual concept

A blue-to-purple gradient background with a glowing humanoid robot holding a smartphone, a neural-network mesh behind it, three floating UI panels showing "+40% conversions", "98% satisfaction" and a rising line chart, the Helvaro logo in two corners, and a badge reading "POWERED BY AI".

**Why it fails:** the exact banned palette; a generic robot instead of Faro; fabricated metrics presented as results; dashboards as decoration; duplicated logos; visual clutter; and it would look identical to every other AI startup's feed.

---

## 23. WHERE THINGS LIVE (and what you must not edit)

Only relevant if you are asked to change the **website** rather than write social content. The site has no framework and no npm — only Perl.

| Path | What | Edit? |
|---|---|---|
| `/` (root) | Dutch source pages | **Yes — this is where you edit** |
| `/fr/ /en/ /de/ /es/` | Generated translations | **No. Overwritten on next build** |
| `agents/*.html` | Generated from `tools/agents-data.pl` | **No** — edit the data file |
| `koppelingen/*.html` (except `index.html`) | Generated from `tools/koppelingen-data.pl` | **No** — edit the data file |
| Nav and footer in every page | Generated from `tools/shell/nav.html` + `footer.html` | **No** — edit the shell, then `sync-shell.pl` |
| `js/lang/*.js` | Translation dictionaries | Yes, via `tools/vert/` |
| `js/i18n.js` | Hero lines and formatted blocks | Yes |
| `css/style.css` | The whole design system, ~8.800 lines with rationale comments | Yes, carefully |

After any content change: `sh tools/build.sh` (syncs shell, rebuilds agents, koppelingen, the four language folders, the sitemap, and checks every internal link).

Two rules that follow from this:
- **Never hand-edit a translated page.** The change disappears at the next build.
- **Never hand-edit an agent or koppeling page.** Change `tools/agents-data.pl` or `tools/koppelingen-data.pl` and rebuild.

---

## 24. QUICK REFERENCE

**Positioning:** Het verkoopsysteem voor autobedrijven. Elke voertuigaanvraag, afgehandeld.
**Not:** a chatbot, an AI assistant, a lead-gen tool, a telephony product, a replacement for salespeople.
**Audience:** independent Belgian car dealers and occasiondealers, 40–300 cars, 2–8 salespeople.
**Channels:** website (live) · WhatsApp (live) · e-mail (in ontwikkeling). No phone, deliberately.
**Colours:** `#E8D7B1` sand on `#121212` black · cards `#232323` · borders `#333333` · text `#F9F9F9` / `#B5B5B5` / `#999999` · bronze `#B08A4A` (accent) / `#8A6A33` (deep) on white.
**Type:** Bricolage Grotesque 600 (headings, line-height 1.04–1.08) · Inter (body) · Instrument Serif italic, sand, rare — headline highlights and the price figure only.
**Logo:** one file, `logo-wordmark.png`, gold, recoloured per theme by CSS filter. The sand/bronze mark PNGs are unused leftovers.
**Mascot:** Faro, a falcon with gold eye rings, beak, talons and chest crest. Black in all six pose renders; a white version exists only as the large hero render. Not a robot. Not orange. Not geometric.
**Voice:** tension pairs. No exclamation marks, no superlatives, no em dashes. Never "de AI" (but "agent" and "werkstroom" are fine).
**Languages:** NL (je) · FR (vous) · EN (you) · DE (Sie) · ES (informal).
**Lead offer:** the pilot — five dealers, six weeks, one measured number. Demo at `helvaro.pro/meeting.html`.
**Results:** none measured yet, and the brand says so. Five pilot places open.
**The test:** would a fifty-year-old dealer trust this with his customers, and does it look like every other AI startup?
