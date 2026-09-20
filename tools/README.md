# Bouwstappen

De site heeft geen framework en geen npm. Alleen perl, dat staat er al op.

## Na elke inhoudelijke wijziging

```
sh tools/build.sh
```

Dat is een korte weg voor:

```
perl tools/sync-shell.pl        kop en voet gelijktrekken
perl tools/build-agents.pl      de tien agentpagina's schrijven
perl tools/build-koppelingen.pl de koppelingspagina's schrijven
perl tools/build-langs.pl       /fr/ /en/ /de/ /es/ genereren
perl tools/build-sitemap.pl     sitemap.xml schrijven
perl tools/check-links.pl       elke interne link nalopen
```

## Wat waar staat

| Map of bestand | Wat | Bewerken? |
|---|---|---|
| `/` (hoofdmap) | Nederlandse bron | **Ja, hier bewerk je** |
| `/fr/ /en/ /de/ /es/` | Gegenereerd | **Nee. Wordt overschreven** |
| `agents/*.html` | Gegenereerd uit `tools/agents-data.pl` | **Nee** |
| `koppelingen/*.html` behalve `index.html` | Gegenereerd uit `tools/koppelingen-data.pl` | **Nee** |
| `<!-- SHELL:NAV -->` … in elke pagina | Gegenereerd uit `tools/shell/` | **Nee** |
| `tools/agents-data.pl` | De tekst van de tien agents | Ja |
| `tools/koppelingen-data.pl` | De tekst en de status per koppeling | Ja |
| `tools/shell/nav.html` en `footer.html` | Navigatie en voettekst | Ja |
| `js/lang/*.js` | Woordenboeken | Ja, via `tools/vert/` |
| `js/i18n.js` | Hero en blokken met opmaak | Ja |

Alles wat gegenereerd is, wordt bij de volgende build weggegooid en opnieuw
geschreven. Bewerk je daar iets met de hand, dan is dat de volgende keer weg.

## De navigatie aanpassen

Eén plek: `tools/shell/nav.html`. Daarna `perl tools/sync-shell.pl`, en de
kop staat in alle pagina's gelijk, met per map het juiste aantal `../`.
Hetzelfde geldt voor `tools/shell/footer.html`.

Bewerk de navigatie nooit in een pagina zelf. Met dertig pagina's loopt dat
binnen een week uit elkaar, en dat merk je pas als een bezoeker op een dode
link klikt.

## De tekst van een agent aanpassen

De tien agentpagina's hebben dezelfde opbouw. Die opbouw staat in
`tools/build-agents.pl`, de tekst in `tools/agents-data.pl`. Pas de tekst
daar aan en draai:

```
perl tools/build-agents.pl
```

Hetzelfde patroon geldt voor de koppelingen, met
`tools/koppelingen-data.pl`.

## De status van een koppeling

In `tools/koppelingen-data.pl` staat per koppeling een `status`:

| Waarde | Betekent |
|---|---|
| `live` | Het draait bij een echte garage en je kunt het in een demo tonen |
| `bouw` | Er wordt aan gebouwd, het staat nog niet bij een klant |
| `plan` | We willen het bouwen, er ligt nog niets |

Zet nooit iets op `live` omdat het bijna af is. De hele site hangt aan dat
onderscheid, en een te vroege claim merk je pas tijdens een demo.

## Vertalen

Vertalingen gaan per blok via een tabbestand met vijf kolommen:

```
nederlands <TAB> frans <TAB> engels <TAB> duits <TAB> spaans
```

Die bestanden staan in `tools/vert/`. Voeg er een toe en draai:

```
perl tools/voeg-vertalingen.pl tools/vert/blok-14.txt
perl tools/build-langs.pl
```

Vier talen naast elkaar schrijven houdt de termen gelijk. Vier losse
JavaScript-bestanden bijwerken nodigt uit tot verschillen, en dan staat er
op de Franse pagina ineens een ander woord voor hetzelfde ding.

Weet je niet wat er nog mist:

```
perl tools/build-langs.pl --dump
```

Dat schrijft `tools/mist-<taal>.txt` met de ontbrekende zinnen voluit. Een
zin zonder vertaling valt terug op het Nederlands. Dat breekt niets, maar op
een Franse pagina valt het meteen op.

Paginatitels en meta-omschrijvingen gaan door hetzelfde woordenboek. Alleen
de oudste pagina's staan nog in `TITLES` in `js/i18n.js`.

## Een nieuwe pagina toevoegen

1. Zet het pad, de titel en de omschrijving in `@PAGINAS` in
   `tools/nieuwe-paginas.pl` en draai dat script. Het schrijft een geraamte
   met de juiste `canonical`, `hreflang` en merktekens. Bestaande pagina's
   worden nooit overschreven.
2. Schrijf de inhoud tussen `<main id="main">` en `</main>`.
3. Voeg het pad toe aan `@PAGES` in `tools/sync-shell.pl`, aan `@PAGINAS` in
   `tools/build-langs.pl` en aan `@PAGES` in `tools/build-sitemap.pl`.
4. Zet de titel en de omschrijving in een blok in `tools/vert/`.
5. `sh tools/build.sh`

## Lokaal bekijken

```
perl tools/serve.pl 8080
```

Daarna `http://localhost:8080`. Alleen om te kijken: één verzoek tegelijk en
hij serveert enkel uit de map waarin hij start.

## Waarom de taalmappen bestaan

De site vertaalde vroeger alleen in de browser. Alle vijf de talen deelden
één URL, dus Google zag enkel het Nederlands. Voor een Belgisch bedrijf is
dat duur: Wallonië en Brussel zoeken in het Frans en vonden niets.

Nu heeft elke taal een eigen URL met `hreflang` ernaartoe, en is de
taalkiezer een echte link in plaats van een schakelaar in de browser. Zo
komen de inhoud en de canonical van een pagina altijd overeen.
