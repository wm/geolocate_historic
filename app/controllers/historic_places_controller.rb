class HistoricPlacesController < ApplicationController
  # GET /historic_places
  # GET /historic_places.xml
  def index
    @historic_places = HistoricPlace.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @historic_places }
    end
  end

  # GET /historic_places/1
  # GET /historic_places/1.xml
  def show
    @historic_place = HistoricPlace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historic_place }
    end
  end

  # GET /historic_places/new
  # GET /historic_places/new.xml
  def new
    @historic_place = HistoricPlace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @historic_place }
    end
  end

  # GET /historic_places/1/edit
  def edit
    @historic_place = HistoricPlace.find(params[:id])
  end

  # POST /historic_places
  # POST /historic_places.xml
  def create
    @historic_place = HistoricPlace.new(params[:historic_place])

    respond_to do |format|
      if @historic_place.save
        flash[:notice] = 'HistoricPlace was successfully created.'
        format.html { redirect_to(@historic_place) }
        format.xml  { render :xml => @historic_place, :status => :created, :location => @historic_place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historic_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /historic_places/1
  # PUT /historic_places/1.xml
  def update
    @historic_place = HistoricPlace.find(params[:id])

    respond_to do |format|
      if @historic_place.update_attributes(params[:historic_place])
        flash[:notice] = 'HistoricPlace was successfully updated.'
        format.html { redirect_to(@historic_place) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @historic_place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /historic_places/1
  # DELETE /historic_places/1.xml
  def destroy
    @historic_place = HistoricPlace.find(params[:id])
    @historic_place.destroy

    respond_to do |format|
      format.html { redirect_to(historic_places_url) }
      format.xml  { head :ok }
    end
  end
end
