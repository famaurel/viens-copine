class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :session_id
      t.string :publisher_token
      t.string :subscriber_token
      t.timestamps
    end
  end
end
