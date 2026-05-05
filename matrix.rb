#!/usr/bin/env ruby
require_relative "lib/diamante/matrix"

trap("SIGINT") do
  print "\e[2J\e[H"

  puts "Morpheus: 'Follow me.'"
  exit!
end

matrix = Matrix.new(" Agile & Craftsmanship Canarias ", "examples/matrix/title.txt")
matrix.call
