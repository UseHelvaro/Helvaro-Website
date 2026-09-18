#!/bin/sh
# Bouwt de taalmappen en de sitemap. Draai dit na elke inhoudelijke wijziging
# aan een Nederlandse pagina. Zie tools/README.md.
set -e
cd "$(dirname "$0")/.."
perl tools/build-langs.pl
perl tools/build-sitemap.pl
