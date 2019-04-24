class CreatePostContent < ActiveRecord::Migration[5.2]
  def change
    create_table :post_contents do |t|
      t.string :media_url
      t.float :geo_long
      t.float :geo_lat
      t.references :post, foreign_key: true
      t.timestamps null: false
    end
  end
end
