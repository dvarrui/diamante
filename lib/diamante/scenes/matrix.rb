# frozen_string_literal: true

require "pastel"
require_relative "../ansi"

module Diamante
  module Scene
    class Matrix
    
      def initialize(config)
        @config = config
        @pastel = Pastel.new
        @matrix_chars = @config[:chars].chars
        @term = ANSI.new
        @height = @term.height
        @width = @term.width
        @chars = {}
      end
      
      def render
        @chars[rand(@width)] = 0
    
        @chars.each do |col, row|
          @chars[col] += 1
          print_random_char_at(row, col)
        end
        print_char_at_ramdom("•")
      end
        
      private 
          
      def print_random_char_at(row, col) 
        if rand > 0.3
          text = @pastel.green("#{@matrix_chars.sample} ")
        else
          text = @pastel.green.bold("#{@matrix_chars.sample} ")
        end
        ANSI.print_text_at(row + 1, col, text)
      end
        
      def print_char_at_ramdom(char)
        return if rand > 0.2
    
        row = rand(@height)
        col = rand(@width)
        text = @pastel.white(char)
        ANSI.print_text_at(row + 1, col, text)
      end
    end  
  end
end

