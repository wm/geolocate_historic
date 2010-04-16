Assignment 3 for COMP 120 @ Tufts 
==

Geolocation and National Historic Places
--

[link to actual assignment](http://www.cs.tufts.edu/comp/120/assignments/a3.php)

I wrote two models and a helper class. 

1. HistoricPlace objects store all the CSV parsed places
1. DistanceHelper class in lib/distance_helper.rb helps to generate SQL to search for placed near a give location.
1. Google API Key is defined separately in production.rb and development.rb so that I can develop with a localhost dev license and use a production license too.
1. I overwrite the HistoricPlace.calc method to display distances with 2 decimal places
1. Store all locations queried from and update their query_count (and time stamp) if multiple queries from one location. 
1. Uses JQTouch for mobile version. 
1. Use index to test browser type and render m.html if mobile otherwise I run another method.
1. I have a library file to be used to load the csv file. It need the Rails environment so call it with script/runner.

To parse the data file run

    ruby ./script/runner ./lib/ne_parser.rb csv-file.csv

Benchmarks

		bash-3.2$ ./script/performance/benchmarker 'HistoricPlace.all'
		            user     system      total        real
		#1      0.510000   0.080000   0.590000 (  0.701018)
		
		 ./script/performance/benchmarker 'HistoricPlace.find_places_within(42.4083349,-71.1159683,3)'
		            user     system      total        real
		#1      0.010000   0.000000   0.010000 (  0.081882)
		
		bash-3.2$ ./script/performance/benchmarker 'HistoricPlace.find_places_within(42.4083349,-71.1159683,10)'
		            user     system      total        real
		#1      0.020000   0.000000   0.020000 (  0.111107)