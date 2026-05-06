# frozen_string_literal: true

require "pastel"
require_relative "../ansi"

module Diamante
  module Scene
    class Slides
      attr_reader :index
    
      def initialize(config)
        @config = config
        @pastel = Pastel.new
        @eligible_chars = "ª\|@·#$~%&/\¿¸^*¨;•:·_-+'.,".chars + ['.', ' ']
        @term = ANSI.new
        @height = @term.height
        @width = @term.width

        @files = Dir.glob(@config[:files])
        @index = 0
        load_slide
      end
      
      def count
        @files.count
      end

      def render
        @chars[rand(@width)] = 0
    
        @chars.each do |col, row|
          @chars[col] += 1
          print_random_char_at(row, col)
        end
        print_char_at_ramdom("•")
        show_slide_content
      end
  
      def next
        return unless @index + 1 < @files.size
        @index += 1
        load_slide
      end
  
      def prev
        return unless @index > 0
        @index -= 1
        load_slide
      end
        
      private 
  
      def load_slide
        @chars = {}
        ANSI.clear_screen  
        @slide = File.readlines(@files[@index])
      end
        
      def print_random_char_at(row, col) 
        if rand > 0.3
          text = @pastel.green("#{@eligible_chars.sample} ")
        else
          text = @pastel.green.bold("#{@eligible_chars.sample} ")
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
    
      def show_slide_content
        lines = @slide
        row = (@height / 2) - (lines.size / 2)
        max_with = lines.map(&:length).max
        col = (@width / 2) - (max_with / 2)
      
        lines.each_with_index do |text, index|
          text = @pastel.white.bold(text)
          ANSI.print_text_at(row + 1 + index, col,text)
        end
      end
    end  
  end
end

