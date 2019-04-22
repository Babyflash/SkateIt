class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins do |t|
      t.references :skater, foreign_key: true
      t.references :spot, foreign_key: true
      t.timestamps null: false
    end
  end
end
