require 'thor'
require 'erb'
module Station
  module Command
    class Generate < Thor # :nodoc:
      desc 'generation migration', ''
      def migration(args)
        raise "#{args} error" unless args.is_a?(Array) || args.size < 2
        parser = args.shift
        file_name = args.shift
        file_path = dest_path(parser, file_name)
        class_name = file_name.camelize
        path = template_filepath('migration')
        data = render IO.read(path), class_name: class_name
        File.open(file_path, 'w') do |f|
          puts "create file #{file_path}"
          f.write data
        end
        puts 'done'
      rescue Errno::ENOENT => e
        puts "#{e.message} \n#{e.backtrace[0..5].join("\n")}"
      end

      protected

      def render(template, vars)
        ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
      end

      def template_filepath(method)
        "#{Station.root}/station/generators/templates/#{method}.erb"
      end

      def dest_path(module_name, file_name)
        module_path = "#{Station.root}/parser/#{module_name}"
        raise "#{module_path} not exist" unless File.exist?(module_path)
        migrate_path = "#{module_path}/db/migrate"
        unless File.exist?(migrate_path)
          raise "#{migrate_path} not exist"
        end
        ms = Time.now.to_f.to_s.gsub('.', '')
        "#{migrate_path}/#{ms}_#{file_name}.rb"
      end
    end
  end
end
