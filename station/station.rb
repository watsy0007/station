require 'logger'
module Station
  module_function

  attr_accessor :_env
  attr_accessor :_logger
  attr_accessor :_schedule, :_cache
  attr_accessor :_thread_count

  def configuration
    yield self if block_given?
  end

  def env
    @_env ||= ActiveSupport::StringInquirer.new(ENV['STATION_ENV'] || 'development')
  end

  def logger
    @_logger ||= begin
                   Station::Logger.logger = ::Logger.new(STDERR).tap do |l|
                     l.level = ::Logger::DEBUG
                   end
                   Station::Logger.logger
                 end
  end

  def root
    File.expand_path('.')
  end

  def thread_count
    @_thread_count ||= 1
  end

  def thread_count=(count)
    @_thread_count = count
  end

  def cache
    @_cache ||= Station::MemoryCache.new
  end

  def cache=(item)
    @_cache = item
  end

  def schedule
    @_schedule ||= Station::MemorySchedule.new
  end

  def proxies
    @_proxies ||= Station::Proxies.new
  end

  def schedule=(item)
    @_schedule = item
  end

  def init
    %w(application_record command launcher logger producer station utils).each do |f|
      require "#{Station.root}/station/#{f}"
    end
    %w(cache command db fundation generators lib model proxy schedule).each do |dir|
      Dir["#{Station.root}/station/#{dir}/**/*.rb"].each do |file|
        require file
      end
    end
  end
end

Station.init
