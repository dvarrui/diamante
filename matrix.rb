#!/usr/bin/env ruby
require_relative "lib/diamante/matrix/manager"
require "debug"

if ARGV.size < 1
  puts "Usage: #{$0} PATH/TO/CONFIG.yaml"
  exit 1
end

manager = Matrix::Manager.new(ARGV.first)
manager.call
