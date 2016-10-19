require_relative '../../../station'
require 'active_record'
require 'yaml'
require 'erb'

namespace :itjuzi do
  namespace :db do
    def current_path
      "#{Engine.root}/parser/itjuzi"
    end

    def database_config
      result = ERB.new(IO.read("#{current_path}/config/database.yml")).result
      YAML.load(result).deep_symbolize_keys!.freeze[Engine.env.to_sym]
    end

    task create: :environment do
      config = database_config
      ActiveRecord::Base.logger = Engine.logger
      ActiveRecord::Base.establish_connection config.merge(database: nil)
      ActiveRecord::Base.connection.create_database config[:database]
    end
    task migrate: :environment do
      version = ENV['VERSION']
      path = "#{current_path}/db/migrate"
      ActiveRecord::Migrator.migrate(path, version ? version.to_i : nil)
    end

    task :environment do
      config = database_config
      ActiveRecord::Base.logger = Engine.logger
      ActiveRecord::Base.establish_connection config
    end
  end
end
