class HistoricPlacesController < ApplicationController
  DISTANCE = 2 # in miles
  
  def index
    # GAPI_KEY set in <development|production>.rb to have one for dev mode on
    # localhost and one for production mode on heroku
    @gkey = GAPI_KEY 
    @historic_places = []
    
    if params[:lat] && params[:lng]
      
      # Find those places nearby
      distance_calculation = DistanceHelper.distance_calc(
          params[:lat],
          params[:lng],
          DISTANCE,
          HistoricPlace.table_name,
          'id,title,lat,lng'
      )
      @historic_places = HistoricPlace.find_by_sql(distance_calculation)
      
      # Save the location being queried 
      ql = QueryLocation.new(:lat => params[:lat], :lng => params[:lng])
      unless ql.save
        logger.debug(ql.errors.to_xml)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @historic_places }
      format.json  { render :json => @historic_places }
    end
  end

  # Display the info for a particular site
  def info
    @historic_place = HistoricPlace.find(params[:id])

    respond_to do |format|
      format.html { render :layout => false }
      format.xml  { render :xml => @historic_place }
      format.json  { render :json => @historic_place }
    end
  end
  
end
