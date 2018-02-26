class AddColumnsToDeviseUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :devise_users, :uid, :string
    add_column :devise_users, :provider, :string
  end
end
