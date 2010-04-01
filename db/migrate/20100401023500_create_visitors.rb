class CreateVisitors < ActiveRecord::Migration
  def self.up
    create_table :visitors do |t|
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :visitors
  end
end
