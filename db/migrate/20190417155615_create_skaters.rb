class CreateSkaters < ActiveRecord::Migration[5.2]
  def change
    create_table :skaters do |t|
      t.string :authentication_id
      t.string :nickname
      t.string :wechat_id
      t.string :gender
      t.string :avatar
      t.string :city
      t.string :country
      t.string :language

      t.timestamps null: false
    end
  end
end
