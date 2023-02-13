TN Map of Fire Hydrants taken from OSM 
========

This has been a fun experiment on pulling data from OSM and displayig it in Leaflet

URL
========
https://northrivergeo.github.io/tnfiremap

How it Works
========

In the scripts directory is a very simple script called "process.sh" that pulls all the Fire Hydrants from OSM in a bounding box, clips against the TN boundary, and pushes the result into a leaflet readable location. I then manually push it into Github. 

Future
======== 

* Add Firestations. 

* Project out of 4326 into 2274 

