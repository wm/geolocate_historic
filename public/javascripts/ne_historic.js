map = null;

initialize = function() {
	if(navigator.geolocation) {
		show_dialog("#map_dialog","Notice","We are determining you location<br/>one moment please");
    navigator.geolocation.getCurrentPosition(sc,ec);
  }else{	
    hide_dialog("#map_dialog");
		show_dialog("#map_dialog","Notice","This browser is not supported, sorry!");
  }
}

//Run on successful location lookup
sc = function(position) {  
	$('#page').show();
	map = new GMap2(document.getElementById("map_canvas"));
  map.setCenter(new GLatLng(position.coords.latitude,position.coords.longitude), 13);
	map.setUIToDefault();
	getPlacesByLocation(position.coords.latitude,position.coords.longitude);
}

ec = function(error) {
	show_dialog("Error","Unable to determine your location! Why not try <a href='http://getfirefox.com'>something better</a>");
}

show_dialog = function(id,title,html){
  $(id).html(html).dialog({title: title});
}

hide_dialog = function(id){
	$(id).dialog('close')
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

getPlacesByLocation = function(lat,lng){
  hide_dialog("#map_dialog");
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
        var hp = this['historic_place'];
        var url = '/historic_places/info/'+hp.id;
				var marker = addPoint(index,hp.lat,hp.lng,hp.title,url);
        var letter = String.fromCharCode("A".charCodeAt(0) + index);
	      var title = hp.title;
        var row = "<tr id='hp_"+hp.id+"'><td>"+letter+". <a id='icon_"+letter+"' href='#'>"+title+"</a></td></tr>";
        $('table#historic_places tbody:first').append(row);
        $('#icon_'+letter).click(function(){
	        var openFnCallback = function() {$('.map_icon_window_area').load(url);};
				  var html = "<div class='map_icon_window_header'>"+title+"</div><div class='map_icon_window_area'><img src='/images/loading.gif'></img></div>"
					map.openInfoWindowHtml(marker.getLatLng(),html,{onOpenFn: openFnCallback});
			  });
        
      });
      hide_dialog("#map_dialog");
    }
  });
};