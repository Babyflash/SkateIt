class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.integer :spot_rating
      t.string :difficulty_rating
      t.string :default_image
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
