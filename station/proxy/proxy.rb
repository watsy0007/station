module Station
  class Proxy < ::Array # :nodoc:
    def host
      self[0].to_s if size > 1
    end

    def port
      self[1].to_i if size > 1
    end

    def username
      self[2].to_s if size > 3
    end

    def password
      self[3].to_s if size > 3
    end
  end
end
