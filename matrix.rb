#!/usr/bin/env ruby
require_relative "lib/diamante/matrix"
require "debug"

matrix = Matrix.new("examples/matrix/config.yaml")

trap("SIGINT") do
  print "\e[2J\e[H"

  puts matrix.bye
  exit!
end

matrix.call
