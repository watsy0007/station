require_relative './station'

Dir['parser/*/tasks/*.rake'].each { |f| load f }
load 'engine/Rakefile'

task :launch do
  Engine::Launcher.new.start
end

desc 'show module list'
task :module_list do
  Dir['parser/*'].each { |dir| puts dir.split('/').last }
end

def db_operation(operator)
  Dir['parser/*'].each do |dir|
    module_name = dir.split('/').last
    Rake::Task["db:#{operator}"].invoke(module_name)
  end
end

desc 'create all module database'
task :create_all do
  db_operation(:create)
end

desc 'migrate all module database'
task :migrate_all do
  db_operation(:migrate)
end

task default: %w[launch]
