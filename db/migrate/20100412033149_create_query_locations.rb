class CreateQueryLocations < ActiveRecord::Migration
  def self.up
    create_table :query_locations do |t|
      t.column "lat", :decimal, :precision => 15, :scale => 10
      t.column "lng", :decimal, :precision => 15, :scale => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :query_locations
  end
end
