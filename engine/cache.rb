require 'active_support/core_ext/module/delegation'
module Engine
  class Cache
    include Celluloid
    attr_accessor :caches
    def initialize
      @caches = {}
    end

    def []=(key, value)
      @caches[key] = value
    end

    delegate :include?, to: :caches

    def inspect
      puts @caches.keys
    end
  end
end
