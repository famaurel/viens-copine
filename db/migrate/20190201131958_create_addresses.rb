class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :title
      t.float :latitude
      t.float :longitude
      t.integer :state

      t.timestamps
    end
  end
end
