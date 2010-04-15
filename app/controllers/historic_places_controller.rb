class HistoricPlacesController < ApplicationController
    
  def index
    case request.user_agent
    when /(iPhone|Android)/i
      render :file => "#{RAILS_ROOT}/public/m.html"
    when /(gecko|opera|konqueror|khtml|webkit)/i
      desktop
    else
      desktop
    end
  end
  
  def mobile
    get_historic_places
    respond_to do |format|
      format.html { render :layout => false} # mobile.html.erb
    end
  end
   
  def desktop
    get_historic_places
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
  
  private
  
  def get_historic_places
    # GAPI_KEY set in <development|production>.rb to have one for dev mode on
    # localhost and one for production mode on heroku
    @gkey = GAPI_KEY 
    @historic_places = []
    ip = request.remote_ip
    @lat = params[:lat]
    @lng = params[:lng]
    if @lat && @lng
      @historic_places = HistoricPlace.find_places_within(params[:lat],params[:lng],DISTANCE)
      @ql = QueryLocation.find_by_ip(ip)
      @ql ||= QueryLocation.new
      @ql.ip = ip
      @ql.lat = @lat
      @ql.lng = @lng
      @ql.save
    else
      # Store the location or update it.
      @ql = QueryLocation.find_by_ip(ip)
      @ql ||= QueryLocation.new
      @ql.ip = ip
      @ql.save
    end
  end  
  
end
