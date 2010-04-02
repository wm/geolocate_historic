map = null;

initialize = function() {
	if(navigator.geolocation) {
		show_dialog("#map_dialog","Notice","We are determining you location<br/>one moment please");
    navigator.geolocation.getCurrentPosition(sc,ec);
  }else{
		show_dialog("#map_dialog","Notice","This browser is not supported, sorry!");
  }
  map = new GMap2(document.getElementById("map_canvas"));
  map.setCenter(new GLatLng(37.4419, -122.1419), 13);
	map.setUIToDefault();
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
    marker.openInfoWindowHtml("<h3>"+letter+". "+title+"</h3>");
  });
  return marker;
}

addPoint = function(index,lat,lng,title,url){
	var point = new GLatLng(lat,lng);
	var marker = new createMarker(point,index,title,url);
  map.addOverlay(marker);
  return marker;
}

addHomePoint = function(lat,lng){
	var point = new GLatLng(lat,lng);
	var homeIcon = new GIcon();
	homeIcon.image = "http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=home|996600";
	homeIcon.shadow = "http://chart.apis.google.com/chart?chst=d_map_pin_shadow";
	homeIcon.iconAnchor = new GPoint(6, 20);
	homeIcon.infoWindowAnchor = new GPoint(5, 1);
	// Set up our GMarkerOptions object literal
	markerOptions = { icon:homeIcon };
	var marker = new GMarker(point, markerOptions);	
	map.addOverlay(marker);
  return marker;
}

show_dialog = function(id,title,html){
  $(id).html(html).dialog({title: title});
}

hide_dialog = function(id){
	$(id).dialog('close')
}

getPlacesByLocation = function(lat,lng){
	map.setCenter(new GLatLng(lat,lng));
	addHomePoint(lat,lng);
	show_dialog("#map_dialog","Notice","One moment while we search for places near you.");
  $.ajax({
    url: 'historic_places',
    dataType: 'json',
    data: {lat: lat, lng: lng},
    success: function(data) {
      $(data).each(function(index,element) {
        // Construct the new row.
        hp = this['historic_place'];
				var marker = addPoint(index,hp.lat,hp.lng,hp.title,'');
        var letter = String.fromCharCode("A".charCodeAt(0) + index);
	      var title = hp.title;
	
        var row = "<tr id='hp_"+hp.id+"'><td>"+letter+". <a id='icon_"+letter+"' href='#'>"+title+"</a></td></tr>";

        $('table#historic_places tbody:first').append(row);
        $('#icon_'+letter).click(function(){
	        marker.openInfoWindowHtml("<h3>"+letter+". "+title+"</h3>");
        });
        
      });
      hide_dialog("#map_dialog");
    }
  });
};

sc = function(position) {  
	getPlacesByLocation(position.coords.latitude,position.coords.longitude);
}

ec = function(error) {  
	show_dialog("Error","Unable to determine your location!");
}