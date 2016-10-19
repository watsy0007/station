require_relative '../schedule'
module Engine
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

    def inspect?
      "#{self.class} #{self} size: #{@queue.size}"
    end
  end
end
