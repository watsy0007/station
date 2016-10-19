require 'logger'
module Engine
  module_function

  class << self
    attr_accessor :_env
    attr_accessor :_logger

    def env
      @_env ||= ActiveSupport::StringInquirer.new(ENV['STATION_ENV'] || 'development')
    end

    def logger
      @_logger ||= begin
                     Engine::Logger.logger ||= ::Logger.new(STDERR).tap do |l|
                       l.level = ::Logger::DEBUG
                     end
                   end
    end

    def root
      File.expand_path('.')
    end
   end
end
