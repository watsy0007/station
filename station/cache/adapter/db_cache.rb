require_relative '../cache'
module Station
  class DbCache < Cache
    attr_accessor :cache
    def initialize
    end

    def []=(key, value)
      # return if include?(key)
    end

    def [](key)
      # @cache.find_by(key: key)
      ::Station::Model::Schedule.progressed.recent_1_day.where(link: key).first
    end

    def include?(key)
      # @cache.exist?(key: key)
      ::Station::Model::Schedule.progressed.recent_1_day.exists?(link: key)
    end

    def inspect
      "<#{self.class} #{self} size:#{@cache.keys.size}"
    end
  end
end
