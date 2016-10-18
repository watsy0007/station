module Itjuzi
  module Model
    class Organization < ::Engine::ApplicationRecord
      establish_connection database_config
    end
  end
end
