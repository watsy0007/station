module Engine
  class Cache < Hash
    include ::MonitorMixin

    alias_method :ori_get, :[]
    alias_method :ori_set, :[]=
    alias_method :ori_include?, :include?
    def []=(key, value)
      synchronize do
        ori_set(key, value)
      end
    end

    def [](key)
      synchronize do
        ori_get(key)
      end
    end

    def include?(key)
      synchronize do
        ori_include?(key)
      end
    end

    def inspect
      "<Engine::Cache #{keys} >"
    end
  end
end
