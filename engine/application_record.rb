module Engine
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.table_name_prefix
      "#{name.to_s.split('::').first.downcase}_"
    end

    def self.database_config
      parse = name.to_s.split('::').first.downcase
      path = "./parser/#{parse}/config/database.yml"
      config = YAML.load(ERB.new(IO.read(path)).result).deep_symbolize_keys!.freeze
      puts config[:development]
      config[:development]
    end

  end
end
