module Station
  module Utils
    module_function

    def module_path(module_name)
      "#{Station.root}/parser/#{module_name}"
    end

    def database_path(module_name)
      root_path = "#{Station.root}/config/database.yml"
      return root_path if module_name.nil?
      path = "#{module_path(module_name)}/config/database.yml"
      return path if File.exist?(path)
      root_path
    end

    def database_config(module_name)
      result = ERB.new(IO.read(database_path(module_name))).result
      YAML.load(result).deep_symbolize_keys!.freeze[Station.env.to_sym]
    end

    def create_database(module_name)
      config = Station::Utils.database_config(module_name)
      ActiveRecord::Base.logger = Station.logger
      begin
        ActiveRecord::Base.establish_connection config
        ActiveRecord::Base.connection
      rescue
        ActiveRecord::Base.establish_connection config.merge(database: nil)
        ActiveRecord::Base.connection.create_database config[:database]
      else
        puts "#{config[:database]}database exists"
        return
      end
    end
  end
end
