require 'active_support/core_ext'
module Engine
  # document
  class Launcher
    include Celluloid
    trap_exit :recover

    def load_config
      Dir["#{Engine.root}/config/initializers/**/*.rb"].each do |f|
        require_relative f
      end
      %w(item model parser).each do |load_path|
        Dir["#{Engine.root}/parser/*/#{load_path}/**/*.rb"].each do |f|
          require_relative f
        end
      end
    end

    def start
      load_config
      Engine.logger.debug('engine launching ...')

      5.times do
        supervisor = Engine::Producer.pool args: [Engine.schedule, Engine.cache]
        supervisor.async.start
      end
      loop { sleep(1_000_000) }
    end

    def recover(actor, reason)
      puts "#{actor}\n#{reason}"
    end
  end
end
