require 'ostruct'

module Engine
  class ParseStruct
    attr_accessor :parse

    def initialize(opts = {})
     @parse = OpenStruct.new(opts)
    end

    def parse_class
      path = "#{namespace}/parser/#{parser}"
      path.camelize.constantize
    end

    def item_class
      path = "#{namespace}/item/#{parser}"
      path.camelize.constantize
    end

    def [](item)
        @parse[item]
    end

    delegate :namespace, :parser, :link, to: :parse
  end
end
