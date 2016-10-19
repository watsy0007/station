require_relative './station'

task default: %w[itjuzi]

Dir['parser/*/tasks/*.rake'].each { |f| load f }

task :itjuzi do
  ruby 'luncher.rb'
end

desc 'show module list'
task :module_list do
  Dir['parser/*'].each { |dir| puts dir.split('/').last }
end
