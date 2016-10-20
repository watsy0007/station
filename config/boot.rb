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
require './station/station'
Celluloid.boot
