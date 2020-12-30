#!/bin/bash
# Script to extract relevant data and populate an osm2pgsql database
cd popdb/mkosm
bash ./mkengwales.sh > mkosm.out 2> mkosm.err
rm *.osm *.osm.pbf
cd ..
/usr/bin/osm2pgsql -U gis -d gis --slim -S popdb_files/ways2.style -C 1000 mkosm/england_wales_relevant.osm.bz2 > popdb.out 2> popdb.err
