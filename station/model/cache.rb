module Station
  module Model
    class Cache < ::Station::ApplicationRecord
      establish_connection database_config
    end
  end
end
