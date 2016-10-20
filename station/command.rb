module Station
  module Command
    class << self
      def invoke(command, args)
        klass = "Station::Command::#{command.capitalize}".camelize.constantize
        method_name = args.shift
        obj = klass.new
        return obj.send(method_name, args) if obj.respond_to?(method_name)
        puts "#{command}: #{args} error"
      end
    end
  end
end
