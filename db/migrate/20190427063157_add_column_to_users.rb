class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :authentication_token, :string, limit: 30
  	add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet
  	add_column :users, :name, :string
    add_column :users, :avatar_url, :string
    add_column :users, :gender, :string
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_index :users, :authentication_token, unique: true
  end
end
