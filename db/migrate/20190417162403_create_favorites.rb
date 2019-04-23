class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :spot_id
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
