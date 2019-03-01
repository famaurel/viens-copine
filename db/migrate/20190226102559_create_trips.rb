class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :transport
      t.integer :start_time
      t.boolean :started, :default => false
      t.references :start_address
      t.references :end_address

      t.timestamps
    end
  end
end
