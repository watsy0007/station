require 'rubygems'
require 'bundler'
require 'byebug'
require 'forwardable'
require 'celluloid/debug'
require 'celluloid/current'
Bundler.setup(:default)
Dir['engine/**/*.rb'].each { |f| require_relative f }
Celluloid.boot
