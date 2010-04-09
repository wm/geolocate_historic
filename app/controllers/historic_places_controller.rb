class HistoricPlacesController < ApplicationController
  def index
    @gkey = GAPI_KEY # env dependant!
    @historic_places = []
    distance = 2
    if params[:lat] && params[:lng]
      select = "id,title,lat,lng"
      # Had to do it this way for PGsql. Heroku only has PGsql. This will also work for MySQL.
      group = "id,title,lat,lng HAVING ((ACOS(SIN(#{params[:lat]} * PI() / 180) * SIN(lat * PI() / 180) + COS(#{params[:lat]} * PI() / 180) * COS(lat * PI() / 180) * COS((#{params[:lng]} - lng) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) <= #{distance}"
      order_by = "((ACOS(SIN(#{params[:lat]} * PI() / 180) * SIN(lat * PI() / 180) + COS(#{params[:lat]} * PI() / 180) * COS(lat * PI() / 180) * COS((#{params[:lng]} - lng) * PI() / 180)) * 180 / PI()) * 60 * 1.1515)"
      @historic_places = HistoricPlace.all(:select => select, :group => group, :order => order_by)
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
end
