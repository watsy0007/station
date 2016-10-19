require 'ostruct'
module Station
  class ParseStruct
    extend Forwardable

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

    def_delegators :@parse, :namespace, :parser, :link, :[]
  end
end
