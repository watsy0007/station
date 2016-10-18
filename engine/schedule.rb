module Engine
  class Schedule < Queue
    include ::MonitorMixin

    def inspect
      "<Engine::Schedule queue.size =#{size} >"
    end

    alias_method :ori_push, :push
    alias_method :ori_pop, :pop
    def push(item)
      synchronize do
        ori_push(item)
      end
    end

    def pop
      synchronize do
        ori_pop
      end
    end
  end
end
