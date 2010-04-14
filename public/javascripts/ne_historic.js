var map = null;
var homeMarker = null;
var calledOnce = false;
var FF_LINK = "<a href='http://getfirefox.com'>something better</a>";
var DETERMIN_LOC = "We are determining you location<br/>one moment please";
var UNSUPPORTED = "This browser is not supported, sorry! Why not try "+FF_LINK;
var UNDETERMINED_LOC = "Unable to determine your location!";
var SEARCH_SITES = "One moment while we search for places near you.";
var HOME_ICON = "http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=home|996600";
var HOME_ICON_SHADOW = "http://chart.apis.google.com/chart?chst=d_map_pin_shadow";

initialize = function() {
	if(navigator.geolocation) {
		show_dialog("#map_dialog","Notice",DETERMIN_LOC);
    navigator.geolocation.getCurrentPosition(sc,ec);
  }else{	
    hide_dialog("#map_dialog");
		show_dialog("#map_dialog","Notice",UNSUPPORTED);
  }
}

// Run on successful location lookup
sc = function(position) {  
	$('#page').show();
	map = new GMap2(document.getElementById("map_canvas"));
  map.setCenter(new GLatLng(position.coords.latitude,position.coords.longitude), 13);
	map.setUIToDefault();
	getPlacesByLocation(position.coords.latitude,position.coords.longitude);
		$('#page').show();
}

ec = function(error) {
	show_dialog("Error",UNDETERMINED_LOC);
}

show_dialog = function(id,title,html){
  $(id).html(html).dialog({title: title});
}

hide_dialog = function(id){
	$(id).dialog('close')
}

// adds a point to the map 
addPoint = function(index,lat,lng,title,url){
	var point = new GLatLng(lat,lng);
	var marker = new createMarker(point,index,title,url);
  map.addOverlay(marker);

  return marker;
}

// add the locaiton of the user browsing
addHomePoint = function(lat,lng){
	var point = new GLatLng(lat,lng);
	var homeIcon = new GIcon();
	homeIcon.image = HOME_ICON;
	homeIcon.shadow = HOME_ICON_SHADOW;
	homeIcon.iconAnchor = new GPoint(6, 20);
	homeIcon.infoWindowAnchor = new GPoint(5, 1);
	// Set up our GMarkerOptions object literal
	markerOptions = { icon:homeIcon };
	var marker = new GMarker(point, markerOptions);	
	map.addOverlay(marker);
	
	
  GEvent.addListener(marker, "click", function() {
	  var html = "<div id='ql'>You are here!<div id='ql-info>"+setQLInfo()+"</div>"
		map.openInfoWindowHtml(marker.getLatLng(),html);
  });

  return marker;
}

// Creates a marker whose info window displays the letter corresponding
// to the given index.
function createMarker(point, index, title, url) {
  // Create a lettered icon for this point using our icon class
  var letter = String.fromCharCode("A".charCodeAt(0) + index);
  var letteredIcon = new GIcon(G_DEFAULT_ICON);
  letteredIcon.image = "http://www.google.com/mapfiles/marker" + letter + ".png";

  // Set up our GMarkerOptions object
  markerOptions = { icon:letteredIcon };
  var marker = new GMarker(point, markerOptions);

  GEvent.addListener(marker, "click", function() {
	  var openFnCallback = function() {$('.map_icon_window_area').load(url);};
	  var html = "<div class='map_icon_window_header'>"+title+"</div><div class='map_icon_window_area'><img src='/images/loading.gif'></img></div>"
		map.openInfoWindowHtml(marker.getLatLng(),html,{onOpenFn: openFnCallback});
  });
  return marker;
}

setupAccordion = function(){
	$("#accordion").hide();				
	$(function() {
			$("#accordion").accordion({
				collapsible: true,
				autoHeight: true,
				fillSpace: true
			});
	});
	$(function() {
			$("#accordionResizer").resizable({
				resize: function() {
					$("#accordion").accordion("resize");
				},
				minHeight: 140
			});
		});
  //minimize the accordion
  $("#accordion").accordion( "activate" , false )      
  $("#accordion").show();
}
getPlacesByLocation = function(lat,lng){
  hide_dialog("#map_dialog");
	map.setCenter(new GLatLng(lat,lng));
	homeMarker = addHomePoint(lat,lng);
	show_dialog("#map_dialog","Notice",SEARCH_SITES);
  $.ajax({
    url: 'historic_places',
    dataType: 'json',
    data: {lat: lat, lng: lng},
    success: function(data) {
	    // add an empty table
			var places = "<table id='historic_places'><tbody></tbody></table>";
      $('#content').html(places);

      $(data).each(function(index,element) {
        // Construct the new row.
        var hp = this['historic_place'];
        var url = '/historic_places/info/'+hp.id;
				var marker = addPoint(index,hp.lat,hp.lng,hp.title,url);
        var letter = String.fromCharCode("A".charCodeAt(0) + index);
	      var title = hp.title;
        var row = "<tr id='hp_"+hp.id+"'><td>"+letter+". <a id='icon_"+letter+"' href='#'>"+title+"</a> "+hp.calc+"mi </td></tr>";
        
        //add new row to table and give it a callback function
        $('table#historic_places tbody:first').append(row);
        $('#icon_'+letter).click(function(){
	        var openFnCallback = function() {$('.map_icon_window_area').load(url);};
				  var html = "<div class='map_icon_window_header'>"+title+"</div><div class='map_icon_window_area'><img src='/images/loading.gif'></img></div>"
					map.openInfoWindowHtml(marker.getLatLng(),html,{onOpenFn: openFnCallback});
			  });
      });
        
	    hide_dialog("#map_dialog");	
			GEvent.trigger(homeMarker,'click');

      setupAccordion();
      hide_dialog("#map_dialog");
    }
  });
};

$(document).ready(function (){
	
	  // Get and keep the Map full screen (document window)
  	if (window.attachEvent) {	// IE
	  	window.attachEvent("onresize", function() {resizeAndCenterMap();} ); 
	  } else { 					// others
		  window.addEventListener("resize", function() {resizeAndCenterMap();} , false); 
	  } 
	  // get window height independent of browser
		function getWHeight() {
			var myHeight = 0;
			if( typeof( window.innerHeight ) == 'number' ) {
				myHeight = window.innerHeight;
			} else if( document.documentElement && document.documentElement.clientHeight) {
				myHeight = document.documentElement.clientHeight;
			} else if( document.body && document.body.clientHeight ) {
				myHeight = document.body.clientHeight;
			}
			return myHeight;
		}
	// set div size
		function setDivSize() {
			if (getWHeight()) { 
				document.getElementById("map_canvas").style.height = (getWHeight()-2) +'px';
			}
		}
	// resize map keeping same centre
		function resizeAndCenterMap() {
			var mapcenter = map.getCenter();
			setDivSize();
			map.checkResize();
			map.setCenter(mapcenter);
		}
	
	if (calledOnce == 0){
	  initialize();
	}
	setDivSize();
	
});