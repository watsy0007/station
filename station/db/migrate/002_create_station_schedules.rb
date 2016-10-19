class CreateStationSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :station_schedules do |t|
      t.string :namespace
      t.string :parser
      t.string :link, index: true
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
