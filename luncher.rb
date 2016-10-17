require './station'
require 'wombat'
require 'active_support/core_ext'
# documents
class Luncher
  include Celluloid
  trap_exit :recover

  def start
    Dir['./parser/**/*.rb'].each do |path|
      next if path == '.' || path == '..'
      require path
    end
    # Engine::Producer.new_link.run
    pool = Engine::Producer.pool
    schedule = Engine::Schedule.new
    cache = Engine::Cache.new
    schedule.push Engine::ParseStruct.new(parser: 'organization_list', link: 'https://www.itjuzi.com/investfirm', namespace: 'itjuzi')
    4.times { |_index| pool.future.run(schedule, cache) }
  end

  def recover(actor, reason)
    puts "#{actor}\n#{reason}"
  end
end

# Luncher.new.start
