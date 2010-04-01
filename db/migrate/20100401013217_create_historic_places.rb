class CreateHistoricPlaces < ActiveRecord::Migration
  def self.up
    create_table :historic_places do |t|
      t.string :title
      t.text :description
      t.column "lat", :decimal, :precision => 15, :scale => 10
      t.column "lng", :decimal, :precision => 15, :scale => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :historic_places
  end
end
