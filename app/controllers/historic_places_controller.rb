class HistoricPlacesController < ApplicationController
    
  def index
    # GAPI_KEY set in <development|production>.rb to have one for dev mode on
    # localhost and one for production mode on heroku
    @gkey = GAPI_KEY 
    @historic_places = []
    
    if params[:lat] && params[:lng]
      @historic_places = HistoricPlace.find_places_within(params[:lat],params[:lng],DISTANCE)
      
      # Store the location or update it.
      ql = QueryLocation.find_near(params[:lat],params[:lng],RADIUS)
      ql ||= QueryLocation.new
      ql.lat = params[:lat]
      ql.lng = params[:lng]
      ql.save
      
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
