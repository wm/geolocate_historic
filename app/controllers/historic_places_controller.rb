class HistoricPlacesController < ApplicationController
  DISTANCE = 2 # in miles
  
  def index
    @gkey = GAPI_KEY # env dependant!
    @historic_places = []
    
    if params[:lat] && params[:lng]
      distance_calculation = distance_calc(params[:lat],params[:lng])
      @historic_places = HistoricPlace.find_by_sql(distance_calculation)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @historic_places }
      format.json  { render :json => @historic_places }
    end
  end

  def info
    @historic_place = HistoricPlace.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @historic_place }
    end
  end
  
  private 
  
  # Returns a string to be used by SQL for calculatin the distance between the
  # point entered and the lat, lng in the database row
  #
  def distance_calc(lat,lng)    
    # Had to do it this way for PGsql. Heroku only has PGsql. 
    # This will also work for MySQL.
    calc = "((ACOS(SIN(#{lat} * PI() / 180) * SIN(lat * PI() / 180) + "
    calc = calc + "COS(#{lat} * PI() / 180) * COS(lat * PI() / 180) * "
    calc = calc + "COS((#{lng} - lng) * PI() / 180)) * 180 / PI()) * 60 * 1.1515)" 
    calc = "SELECT id,title,lat,lng,#{calc} as calc FROM historic_places "
    calc = calc + "GROUP BY id,title,lat,lng HAVING calc <= 2 ORDER BY calc"
  end
end
