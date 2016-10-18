require 'logger'
module Engine
  class Logger
    class << self
      attr_accessor :logger
      def method_missing(method_name, *args, &block)
        if logger.respond_to?(method_name)
          logger.send(method_name, *args, &block)
        else
          super(method_name, *args, &block)
        end
      end
    end

  end
end
