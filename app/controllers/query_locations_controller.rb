class QueryLocationsController < ApplicationController
    
  def index
    @query_locations = QueryLocation.all(:limit => 10, :order => 'updated_at DESC')

    respond_to do |format|
      format.xml  { render :xml => @query_locations }
      format.json  { render :json => @query_locations }
    end
  end
  
end
