class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :transport
      t.string :start_time
      t.string :start_lat
      t.string :start_long
      t.string :end_address
      t.string :end_long
      t.string :end_lat
      t.boolean :started, :default => false

      t.timestamps
    end
  end
end
