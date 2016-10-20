module Station
  module Command # :nodoc:
    ALIASES = {
      'module' => 'new_module'
    }
    class << self
      def invoke(command, args)
        klass = "Station::Command::#{command.capitalize}".camelize.constantize
        method_name = args.shift
        method_name = ALIASES[method_name] || method_name
        obj = klass.new
        return obj.send(method_name, args) if obj.respond_to?(method_name)
        puts "#{command}: #{args} error"
      end
    end
  end
end
