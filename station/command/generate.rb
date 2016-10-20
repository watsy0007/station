require 'thor'
require 'erb'
require 'fileutils'
module Station
  module Command
    class Generate < Thor # :nodoc:
      desc 'generation migration', ''
      def migration(args)
        raise "#{args} error" unless args.is_a?(Array) || args.size < 2
        module_name = args.shift
        file_name = args.shift
        file_path = dest_path(module_name, file_name)
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
      def new_module(args)
        raise "#{args} error" unless args.is_a?(Array)
        module_name = args.shift
        m_path = module_path(module_name)
        return logs("#{module_name} parser exist!") if File.exist?(m_path)
        logs "create #{module_name} module"
        %w(config db/migrate item model parser task).each do |nest_path|
          dir_path = "#{m_path}/#{nest_path}"
          FileUtils.mkdir_p dir_path
          File.new("#{dir_path}/.gitkeep", 'w')
        end
        logs 'done'
      end

      desc 'create parser', ''
      def parser(args)
        raise "#{args} error" unless args.is_a?(Array)
        module_name = args.shift
        parser = args.shift
        logs "create #{module_name} parser : #{parser}"
        File.open(parser_path(module_name, parser), 'w+') do |f|
          template = IO.read(template_filepath('parser'))
          f.write render(template, {module_class_name: module_name.camelize, class_name: parser.camelize})
        end
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

      def module_path(module_name)
        "#{Station.root}/parser/#{module_name}"
      end

      def dest_path(module_name, file_name)
        m_path = module_path(module_name)
        raise "module: #{module_name} not exist" unless Dir.exist?(m_path)
        migrate_path = "#{m_path}/db/migrate"
        raise "#{migrate_path} not exist" unless Dir.exist?(migrate_path)
        ms = Time.now.to_f.to_s.delete('.')
        "#{migrate_path}/#{ms}_#{file_name}.rb"
      end

      def parser_path(module_name, file_name)
        m_path = module_path(module_name)
        puts m_path
        raise "module: #{module_name} not exist" unless Dir.exist?(m_path)
        "#{m_path}/parser/#{file_name}.rb"
      end
    end
  end
end
