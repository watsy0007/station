require 'rubygems'
require 'bundler'
require 'byebug'
require 'monitor'
require 'forwardable'
require 'celluloid/debug'
require 'celluloid/current'
require 'active_record'
require 'wombat'
Bundler.setup(:default)
Dir["#{File.expand_path('../../', __FILE__)}/station/**/*.rb"].each { |f| require_relative f }
Celluloid.boot
