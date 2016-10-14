require 'rubygems'
require 'bundler'
require 'byebug'
require 'celluloid'
Bundler.setup(:default)
Dir['engine/**/*.rb'].each { |f| require_relative f }
