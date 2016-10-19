require 'active_support/core_ext'
module Station
  # document
  class Launcher
    include Celluloid
    trap_exit :recover

    def load_config
      Dir["#{Station.root}/config/initializers/**/*.rb"].each do |f|
        require_relative f
      end
      %w(item model parser).each do |load_path|
        Dir["#{Station.root}/parser/*/#{load_path}/**/*.rb"].each do |f|
          require_relative f
        end
      end
    end

    def start
      load_config
      Station.logger.debug('engine launching ...')

      1.times do
        supervisor = Station::Producer.pool args: [Station.schedule, Station.cache]
        supervisor.async.start
      end
      loop { sleep(1_000_000) }
    end

    def recover(actor, reason)
      puts "#{actor}\n#{reason}"
    end
  end
end
