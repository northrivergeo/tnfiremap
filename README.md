Hamilton County TN Map of Fire Hydrants taken from OSM 
========

This has been a fun experiment on pulling data from OSM and displayig it in Leaflet

URL
========
https://northrivergeo.github.io/tnfiremap

How it Works
========

In the scripts directory is a very simple script called "process.sh" that pulls all the Fire Hydrants and Firestations from OSM in a bounding box, clips against the Hamilton County boundary, and pushes the result into a leaflet readable location. 

There are some gymnastics to get all the firestations in - they come from OSM as polygons and in some cases points. The script pulls a centroid from the polygons and merges it with the points. 



