class CreateQueryLocations < ActiveRecord::Migration
  def self.up
    create_table :query_locations do |t|
      t.column "ip", :string

      t.timestamps
    end
  end

  def self.down
    drop_table :query_locations
  end
end
