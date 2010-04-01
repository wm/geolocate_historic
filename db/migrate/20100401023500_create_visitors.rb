class CreateVisitors < ActiveRecord::Migration
  def self.up
    create_table :visitors do |t|
      t.column "lat", :decimal, :precision => 15, :scale => 10
      t.column "lng", :decimal, :precision => 15, :scale => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :visitors
  end
end
