require_relative './station'
module Station
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.table_name_prefix
      "#{name.to_s.split('::').first.downcase}_"
    end

    def self.database_config
      module_name = name.to_s.split('::').first.downcase
      path = database_path(module_name)
      result = ERB.new(IO.read(path)).result
      config = YAML.load(result).deep_symbolize_keys!.freeze
      config[Station.env.to_sym]
    end

    def self.database_path(module_name)
      path = "#{Station.root}/parser/#{module_name}/config/database.yml"
      path = "#{Station.root}/config/database.yml" unless File.exist?(path)
      path
    end

  end
end
