class AddLngLatToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :geo_lat, :float
    add_column :spots, :geo_lng, :float
  end
end
