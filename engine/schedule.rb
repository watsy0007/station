module Engine
  class Schedule
    extend Forwardable

    attr_accessor :queues
    def initialize
      @queues = Queue.new
    end

    def inspect
      "<Engine::Schedule queue =#{queues} >"
    end

    def_delegators :@queues, :<<, :push, :empty?, :pop
  end
end
