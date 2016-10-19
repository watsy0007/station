require_relative './station'

task default: %w[itjuzi]

Dir['parser/*/tasks/*.rake'].each { |f| load f }
task :itjuzi do
  ruby 'luncher.rb'
end
