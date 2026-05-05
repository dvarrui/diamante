#!/usr/bin/env ruby
require_relative "lib/diamante/matrix/manager"
require "debug"

# matrix = Matrix::Matrix.new(ARGV.first)
# trap("SIGINT") do
#   print "\e[2J\e[H"
  # puts matrix.bye
  # exit!
# end
# matrix.game_loop

manager = Matrix::Manager.new(ARGV.first)
manager.call