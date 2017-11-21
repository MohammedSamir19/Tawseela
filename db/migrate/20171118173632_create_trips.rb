class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :status
      t.references :startpoint
      t.references :endpoint

      t.timestamps

      add_foreign_key :trips, :locations, column: :startpoint_id, primary_key: :id
      add_foreign_key :trips, :locations, column: :endpoint_id, primary_key: :id

    end
  end
end
