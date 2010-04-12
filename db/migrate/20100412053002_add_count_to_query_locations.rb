class AddCountToQueryLocations < ActiveRecord::Migration
  def self.up
    add_column :query_locations, :query_count, :integer, :default => 1
  end

  def self.down
    remove_column :query_locations, :query_count
  end
end
