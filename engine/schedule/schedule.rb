require 'monitor'
module Engine
  class Schedule < BasicObject
    def inspect
      '<Engine::Schedule queue.size abstract >'
    end

    def push(_item)
      raise ''
    end

    def pop
      raise ''
    end
  end
end
