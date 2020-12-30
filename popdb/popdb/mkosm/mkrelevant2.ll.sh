#!/bin/bash
country=$1

# Change to your osmosis
OSMOSIS=/home/nick/osmosis-0.42/bin/osmosis
# Change to your osmconvert
OSMCONVERT=./osmconvert

wget http://download.geofabrik.de/europe/great-britain/${country}-latest.osm.pbf>/dev/null 2>/dev/null	


${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf accept-ways building=* --used-node --wb file=${country}_building.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes place=city,town,village,suburb,hamlet,locality  --wb file=${country}_place.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes natural=peak  --wb file=${country}_peak.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes amenity=pub,restaurant,cafe --wb file=${country}_amenity.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes amenity=parking --tf accept-nodes access=public,yes,permissive --wb file=${country}_parking.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes man_made=*  --wb file=${country}_man_made.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes power=tower  --wb file=${country}_pylon.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes tourism=viewpoint,hostel,camp_site  --wb file=${country}_tourism.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes barrier=stile,gate  --wb file=${country}_stilegate.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf reject-ways --tf accept-nodes railway=station  --wb file=${country}_station.osm.pbf 
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf accept-ways highway=path,footway,track,bridleway,cycleway,byway,service,steps,residential,unclassified,tertiary,secondary,primary,trunk,motorway,unclassified_link,tertiary_link,secondary_link,primary_link,trunk_link,motorway_link --used-node --wb file=${country}_highway.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways natural=* --used-node --wb file=${country}_natural.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways landuse=* --used-node --wb file=${country}_landuse.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways leisure=* --used-node --wb file=${country}_leisure.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf accept-ways waterway=* --used-node --wb file=${country}_waterway.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf accept-relations natural=* --used-way --used-node --wb file=${country}_natural_rel.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf accept-relations landuse=* --used-way --used-node --wb file=${country}_landuse_rel.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf accept-relations leisure=* --used-way --used-node --wb file=${country}_leisure_rel.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways railway=* --used-node --wb file=${country}_railway.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways power=line --used-node --wb file=${country}_powerline.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways amenity=pub,restaurant,cafe --used-node --wb file=${country}_amenity_way.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways amenity=parking --tf accept-ways access=public,yes,permissive --used-node --wb file=${country}_parking_way.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways railway=station --used-node --wb file=${country}_station_way.osm.pbf
${OSMOSIS} --rb file=${country}-latest.osm.pbf --tf reject-relations --tf accept-ways barrier=fence,hedge,ditch,wall,retaining_wall --used-node --wb file=${country}_barrier.osm.pbf


${OSMCONVERT} --object-type-offset=15000000000 ${country}_amenity_way.osm.pbf --all-to-nodes --out-pbf -o=${country}_amenity_way_node_t.osm.pbf
${OSMCONVERT} --object-type-offset=15000000000 ${country}_station_way.osm.pbf --all-to-nodes --out-pbf -o=${country}_station_way_node_t.osm.pbf
${OSMCONVERT} --object-type-offset=15000000000 ${country}_parking_way.osm.pbf --all-to-nodes --out-pbf -o=${country}_parking_way_node_t.osm.pbf

${OSMOSIS} --rb file=${country}_amenity_way_node_t.osm.pbf --tf accept-nodes amenity=pub,restauarant,cafe --wb file=${country}_amenity_way_node.osm.pbf
${OSMOSIS} --rb file=${country}_station_way_node_t.osm.pbf --tf accept-nodes railway=station --wb file=${country}_station_way_node.osm.pbf
${OSMOSIS} --rb file=${country}_parking_way_node_t.osm.pbf --tf accept-nodes amenity=parking --wb file=${country}_parking_way_node.osm.pbf

