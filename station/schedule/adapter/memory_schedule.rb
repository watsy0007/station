require_relative '../schedule'
require 'monitor'
module Station
  class MemorySchedule < Schedule
    attr_accessor :queue

    def initialize
      @queue = ::Queue.new
      @queue.extend(::MonitorMixin)
    end

    def push(item)
      @queue.synchronize do
        @queue.push(item)
      end
    end

    def pop
      @queue.synchronize do
        @queue.pop
      end
    end

    def empty?
      @queue.synchronize do
        @queue.empty?
      end
    end

    def done(_item)
    end

    def failed(_item)
    end

    def inspect
      "#{self.class} #{self} size: #{@queue.size}"
    end
  end
end
