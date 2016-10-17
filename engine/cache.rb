module Engine
  class Cache
    extend Forwardable
    # include Celluloid

    attr_accessor :caches
    def initialize
      @caches = {}
    end

    def_delegators :@caches, :[]=, :[], :include?

    def inspect
      "<Engine::Cache #{@caches.keys} >"
    end
  end
end
