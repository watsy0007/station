require './station'
require 'active_support/core_ext'
# documents
class Luncher
  include Celluloid
  trap_exit :recover

  def load_config
    Dir['parser/**/*.rb'].each { |p| require_relative p }
  end

  def start
    load_config
    schedule = Engine::Schedule.new
    cache = Engine::Cache.new
    schedule.push Engine::ParseStruct.new(
      parser: 'organization_list',
      link: 'https://www.itjuzi.com/investfirm',
      namespace: 'itjuzi'
    )

    Engine::Logger.logger = Logger.new(STDERR).tap do |logger|
      logger.level = Logger::DEBUG
    end
    5.times do |_index|
      supervisor = Engine::Producer.pool args: [schedule, cache]
      supervisor.async.start
    end
    loop { sleep(1_000_000) }
  end

  def recover(actor, reason)
    puts "#{actor}\n#{reason}"
  end
end

Luncher.new.start
