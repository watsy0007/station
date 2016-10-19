require 'logger'
module Station
  class Logger
    class << self
      attr_accessor :logger
      def method_missing(method, *args, &block)
        return logger.send(method, *args, &block) if logger.respond_to?(method)
        super
      end

      def respond_to_missing?(method_name)
        logger.respond_to?(method_name) || super
      end
    end
  end
end
