# Bouwstappen

De site heeft geen framework en geen npm. Twee perl-scripts, verder niets.

## Na elke inhoudelijke wijziging

```
perl tools/build-langs.pl
perl tools/build-sitemap.pl
```

Beide staan ook in `tools/build.sh`, dus dit volstaat:

```
sh tools/build.sh
```

## Wat waar staat

| Map | Wat | Bewerken? |
|---|---|---|
| `/` (hoofdmap) | Nederlandse bron | **Ja, hier bewerk je** |
| `/fr/ /en/ /de/ /es/` | Gegenereerd | **Nee. Wordt overschreven** |
| `js/lang/*.js` | Woordenboeken | Ja, nieuwe zinnen hier toevoegen |
| `js/i18n.js` | Titels, hero, blokken met opmaak | Ja |

De taalmappen worden bij elke build volledig weggegooid en opnieuw
geschreven. Bewerk je daar iets met de hand, dan is dat de volgende keer weg.

## Waarom dit bestaat

De site vertaalde vroeger alleen in de browser. Alle vijf de talen deelden
één URL, dus Google zag enkel het Nederlands. Voor een Belgisch bedrijf is
dat duur: Wallonië en Brussel zoeken in het Frans en vonden niets.

Nu heeft elke taal een eigen URL met `hreflang` ernaartoe, en is de
taalkiezer een echte link in plaats van een schakelaar in de browser. Zo
komen de inhoud en de canonical van een pagina altijd overeen.

## Een nieuwe zin toevoegen

1. Zet de Nederlandse zin in de bronpagina in de hoofdmap.
2. Voeg de vertaling toe in `js/lang/fr.js`, `en.js`, `de.js` en `es.js`.
   Onderaan staat een `Object.assign`-blok, daar mag het bij.
3. Draai `sh tools/build.sh`.

Een zin zonder vertaling valt terug op het Nederlands. Dat breekt niets,
maar het valt wel op. De build meldt zelf wat er ontbreekt, per taal, aan
het eind van `perl tools/build-langs.pl`.


## Een nieuwe pagina toevoegen

Zet hem in de hoofdmap (of in `sectoren/`), voeg het pad toe aan `@PAGES`
in `tools/build-langs.pl` en aan `@PAGES` in `tools/build-sitemap.pl`.
