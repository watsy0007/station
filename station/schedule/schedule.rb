require 'monitor'
module Station
  class Schedule < BasicObject
    def inspect
      '<Station::Schedule queue.size abstract >'
    end

    def push(_item)
      raise ''
    end

    def pop
      raise ''
    end
  end
end