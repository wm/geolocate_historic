class CreateHistoricPlaces < ActiveRecord::Migration
  def self.up
    create_table :historic_places do |t|
      t.string :title
      t.text :description
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :historic_places
  end
end
