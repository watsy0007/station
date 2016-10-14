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
    Engine::Producer.new_link.run
  end

  def recover(actor, reason)
    puts "#{actor}\n#{reason}"
  end
end

Luncher.new.start
