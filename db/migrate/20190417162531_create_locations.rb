class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :geo_tag_longitude
      t.string :geo_tag_latitude
      t.references :spot, foreign_key: true
      t.timestamps null: false
    end
  end
end
