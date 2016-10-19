namespace :station do
  namespace :db do
    desc 'create station db'
    task create: :environment do
      Station::Utils.create_database(nil)
    end

    desc 'migrate station'
    task migrate: :environment do
      version = ENV['VERSION']
      path = "#{Station.root}/station/db/migrate"
      ActiveRecord::Migrator.migrate(path, version ? version.to_i : nil)
    end

    task :environment, [:module_name] do |_t, args|
      config = Station::Utils.database_config(args[:module_name])
      ActiveRecord::Base.logger = Station.logger
      ActiveRecord::Base.establish_connection config
    end
  end
end
