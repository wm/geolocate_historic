Assignment 3 for COMP 120 @ Tufts 
==

Geolocation and National Historic Places
--

"link to actual assignment":http://www.cs.tufts.edu/comp/120/assignments/a3.php

I wrote two models and a helper class. 

1. HistoricPlace objects store all the CSV parsed places
1. DistanceHelper class in lib/distance_helper.rb helps to generate SQL to search for placed near a give location.
1. Google API Key is defined separately in production.rb and development.rb so that I can develop with a localhost dev license and use a production license too.
1. I overwrite the HistoricPlace.calc method to display distances with 2 decimal places
1. Store all locations queried from and update their query_count (and time stamp) if multiple queries from one location. Consider one location to be with in a certain radius not a particular point.

To parse the data file run

./script/runner ./lib/ne_parser.rb csv-file.csv