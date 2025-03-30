#!/bin/bash 

[ -f ../data/hydrant.geojson ] && rm ../data/hydrant.geojson
[ -f ../data/hydrant_conv.geojson ] && rm ../data/hydrant_conv.geojson
[ -f ../data/firestation.geojson ] && rm ../data/firestation.geojson
[ -f ../data/firestation.gpkg ] && rm ../data/firestation.gpkg
[ -f ../data/firestation_p_conv.geojson ] && rm ../data/firestation_p_conv.geojson
[ -f ../data/firestation_x_centroid.geojson ] && rm ../data/firestation_x_centroid.geojson
[ -f ../data/firestation_x_conv.geojson ] && rm ../data/firestation_x_conv.geojson


#grab the data 
wget -O ../data/hydrant.overpassql --post-file=hydrant_request.overpassql "https://overpass-api.de/api/interpreter"
wget -O ../data/firestation_p.overpassql --post-file=firestation_polygon.overpassql "https://overpass-api.de/api/interpreter"
wget -O ../data/firestation_x.overpassql --post-file=firestation_points.overpassql "https://overpass-api.de/api/interpreter"

ogr2ogr -f "GEOJSON" ../data/hydrant_conv.geojson ../data/hydrant.overpassql points
ogr2ogr -f "GEOJSON" ../data/firestation_x_conv.geojson ../data/firestation_x.overpassql points
ogr2ogr -f "GEOJSON" ../data/firestation_p_conv.geojson ../data/firestation_p.overpassql multipolygons --config OSM_USE_CUSTOM_INDEXING NO -nlt POINTS -nln firestations 
ogr2ogr -sql "SELECT ST_PointOnSurface(geometry), * FROM firestations" -dialect sqlite ../data/firestation.gpkg ../data/firestation_p_conv.geojson -nln firestations -nlt point
ogr2ogr -f GPKG -update -append ../data/firestation.gpkg ../data/firestation_x_conv.geojson -nln firestations -nlt point

ogr2ogr -clipsrc ../data/hamilton_county.geojson ../data/hydrant.geojson ../data/hydrant_conv.geojson
ogr2ogr -clipsrc ../data/hamilton_county.geojson ../data/firestation.geojson ../data/firestation.gpkg 


#hyd="var hydrant = {"
#sed -i "1s/.*/$hyd/" ../data/hydrant.geojson 

#fire="var hydrant = {"
#sed -i "1s/.*/$fire/" ../data/firestation.geojson 
