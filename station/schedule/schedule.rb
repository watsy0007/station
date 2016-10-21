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

    def done(_item)
      raise ''
    end

    def failed(_item)
      raise ''
    end
  end
end
