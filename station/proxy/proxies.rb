require 'monitor'
module Station
  class Proxies < BasicObject # :ndoc:
    attr_accessor :proxies

    def initialize
      @proxies = []
      @proxies.extend(::MonitorMixin)
    end

    def push(item)
      @proxies.synchronize do
        @proxies.push(item)
      end
    end

    def pop
      @proxies.synchronize do
        return nil if @proxies.nil?
        @proxies.shift
      end
    end

    def empty?
      @proxies.synchronize do
        @proxies.empty?
      end
    end

    def clone
      obj = Proxies.new
      obj.proxies = @proxies.clone
      obj
    end

    def inspect
      "<Station::Proxies #{self.__id__} size:#{@proxies.size}>"
    end
  end
end
