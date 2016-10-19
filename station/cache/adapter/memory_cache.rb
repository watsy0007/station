require_relative '../cache'
module Station
  class MemoryCache < Cache
    include ::MonitorMixin
    attr_accessor :cache

    def initialize
      @cache = {}
      @cache.extend(::MonitorMixin)
    end

    def []=(key, value)
      @cache.synchronize { @cache[key] = value }
    end

    def [](key)
      @cache.synchronize { @cache[key] }
    end

    def include?(key)
      @cache.synchronize { @cache.include?(key) }
    end

    def inspect
      "<#{self.class} #{self} size:#{@cache.keys.size}"
    end
  end
end
