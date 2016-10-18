require 'active_record'

Options = {
  adapter: :mysql2,
  database: 'station_development',
  pool: 5,
  port: 33_060,
  username: :root,
  host: '0.0.0.0',
  password: 'my-secret-pw'
}


class CreateStationDB
  def create
    ActiveRecord::Base.establish_connection Options.merge(database: nil)
    ActiveRecord::Base.connection.create_database Options[:database]
  end
end

ActiveRecord::Base.establish_connection(Options)

class CreateItJuziOrganization < ActiveRecord::Migration
  def change
    create_table :itjuzi_organizations do |t|
      t.string :link, index: true
      t.string :icon_url
      t.string :name
      t.timestamps null: false
    end
  end
end
