require 'active_support/core_ext/module/delegation'
module Engine
  class Schedule
    include Celluloid
    attr_accessor :queues
    def initialize
      @queues = []
    end

    def push(item)
      @queues << item
    end

    def pop
      @queues.shift
    end

    alias_method :<<, :push
    delegate :empty?, to: :queues
  end
end
