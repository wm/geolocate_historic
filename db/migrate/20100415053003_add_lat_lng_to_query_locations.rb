class AddLatLngToQueryLocations < ActiveRecord::Migration
  def self.up
		add_column :query_locations, :lat, :decimal, :precision => 15, :scale => 10
		add_column :query_locations, :lng, :decimal, :precision => 15, :scale => 10
  end

  def self.down
    remove_column :query_locations, :lat
    remove_column :query_locations, :lng    
  end
end