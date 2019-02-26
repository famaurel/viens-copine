class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :email_address, :string
    add_column :users, :trusted_phone_number, :string
    add_column :users, :address, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :category, :string
    add_column :users, :cni, :string
    add_column :users, :photo, :string
    add_column :users, :visio_url, :string
  end
end
