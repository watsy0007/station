require 'logger'
module Engine
  module_function

  attr_accessor :_env
  attr_accessor :_logger
  attr_accessor :_schedule, :_cache

  def configuration
    yield self if block_given?
  end

  def env
    @_env ||= ActiveSupport::StringInquirer.new(ENV['STATION_ENV'] || 'development')
  end

  def logger
    @_logger ||= begin
                   Engine::Logger.logger = ::Logger.new(STDERR).tap do |l|
                     l.level = ::Logger::DEBUG
                   end
                   Engine::Logger.logger
                 end
  end

  def root
    File.expand_path('.')
  end

  def cache
    @_cache ||= Engine::MemoryCache.new
  end

  def cache=(item)
    @_cache = item
  end

  def schedule
    @_schedule ||= Engine::MemorySchedule.new
  end

  def schedule=(item)
    @_schedule = item
  end
end
