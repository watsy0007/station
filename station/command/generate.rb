require 'thor'
require 'erb'
require 'fileutils'
module Station
  module Command
    class Generate < Thor # :nodoc:
      desc 'generation migration', ''
      def migration(args)
        raise "#{args} error" unless args.is_a?(Array) || args.size < 2
        parser = args.shift
        file_name = args.shift
        file_path = dest_path(parser, file_name)
        File.open(file_path, 'w') do |f|
          logs "create file #{file_path}"
          path = template_filepath('migration')
          f.write render(IO.read(path), class_name: file_name.camelize)
        end
        logs 'done'
      rescue Errno::ENOENT => e
        puts "#{e.message} \n#{e.backtrace[0..5].join("\n")}"
      end

      desc 'create parser module', ''
      def parser(args)
        raise "#{args} error" unless args.is_a?(Array)
        parser = args.shift
        logs "create #{parser} parser"
        path = "#{Station.root}/parser/#{parser}"
        %w(config db db/migrate item model parser task).each do |nest_path|
          FileUtils.mkdir_p "#{path}/#{nest_path}"
        end
        logs 'done'
      end

      protected

      def logs(msg)
        Station.logger.debug msg
      end

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
