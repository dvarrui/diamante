#!/usr/bin/env ruby
require "pastel"

def reset_cursor
  print "\e[H" # Lleva el cursor arriba a la izquierda
end

def clear_screen
  print "\e[2J\e[H"
end


trap("SIGINT") do
  # puts "\033[2J"
  clear_screen

  puts "Morpheus: 'Follow me.'"
  exit!
end

class Matrix
  def initialize(filepath)
    @pastel = Pastel.new
    @eligible_chars = "ª\|@·#$~%&/\¿¸^*¨;•:·_-+'.,".chars + ['.', ' ']
    @height, @width = `stty size`.split.map { _1.to_i }

    @title = File.readlines(filepath)
  end

  def call
    clear_screen

    chars = {}
    loop do
      chars[rand(@width)] = 0

      chars.each do |col, row|
        chars[col] += 1
        print_random_at(row, col)
      end
      print_char_at_ramdom("•")
      title
      sleep 0.1
    end
  end

  private

  def print_random_at(row, col) 
    print "\033[#{row + 1};#{col}H" # move cursor down (row + 1)
    # print random character
    if rand > 0.3
      print @pastel.green("#{@eligible_chars.sample} ")
    else
      print @pastel.green.bold("#{@eligible_chars.sample} ")
    end
    reset_cursor
  end

  def print_text_at(row, col, text) 
    print "\033[#{row + 1};#{col}H"
    print @pastel.white(text)
    print "\033[0;0H"
  end

  def print_char_at_ramdom(char)
    return if rand > 0.2

    row = rand(@height)
    col = rand(@width)
    print "\033[#{row + 1};#{col}H"
    print @pastel.white(char)
    print "\033[0;0H"
  end

  def title
    lines = @title
    row = (@height / 2) - (lines.size / 2)
    col = (@width / 2) - (lines.first.length / 2)
  
    lines.each_with_index do |text, index|
      print "\033[#{row + 1 + index};#{col}H"
      print @pastel.white.bold(text)
      print "\033[0;0H"
    end

    header = " Agile & Craftsmanship Canarias "
    hour = " #{Time.now} "
    print_text_at(1, @width - header.length - 1, header)
    print_text_at(2, @width - hour.length - 1, hour)
  end
end

matrix = Matrix.new("examples/matrix/title.txt")
matrix.call
