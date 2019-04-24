class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.float :geo_long
      t.float :geo_lat
      t.references :spot, foreign_key: true
      t.timestamps null: false
    end
  end
end
