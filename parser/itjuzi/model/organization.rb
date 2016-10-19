module Itjuzi
  module Model
    class Organization < ::Station::ApplicationRecord
      establish_connection database_config
    end
  end
end
