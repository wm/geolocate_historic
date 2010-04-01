/* Check for newly verified sheep, add to table, and highlight.
 * 
 * Downloads all verified sheep that have been updated since the
 * last sheep that was added.
 */
getPlacesByLocation = function(lat,lng){
  $.ajax({
    url: 'historic_places',
    dataType: 'json',
    data: {lat: lat, lng: lng},
    success: function(data) {
      $(data).each(function() {
        // Construct the new row.
        hp = this['historic_place'];
        var row = "<tr id='hp_"+hp.id+"'><td>"+hp.id+"</td><td>"+hp.title+"</td>";
        row += "<td>"+hp.lat+"</td><td>"+hp.lng+"</td>";

        // Add the new row to the table 
        $('table#historic_places tbody:first').append(row);
      });
    }
  });
};