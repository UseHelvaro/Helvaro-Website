#!/bin/sh
# Bouwt alles wat gegenereerd wordt, in de juiste volgorde. Draai dit na elke
# inhoudelijke wijziging. Zie tools/README.md.
#
# De kop en de voet gaan twee keer langs: de eerste keer voor de bestaande
# pagina's, de tweede keer voor de agent- en koppelingspagina's die er net
# tussen geschreven zijn.
set -e
cd "$(dirname "$0")/.."

perl tools/sync-shell.pl
perl tools/build-agents.pl
perl tools/build-koppelingen.pl
perl tools/sync-shell.pl
perl tools/build-langs.pl
perl tools/build-sitemap.pl
perl tools/check-links.pl
perl tools/herstel-tekens.pl --kijk   # stopt de build bij dubbel gecodeerde tekens
