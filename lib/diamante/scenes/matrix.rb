require "pastel"
require "yaml"
require_relative "../ansi"

module Diamante
  module Slider
    class Matrix
      attr_reader :bye
      attr_reader :index
    
      def initialize(configfile)
        data = YAML.load(File.read configfile)
        @pastel = Pastel.new
        @eligible_chars = "ª\|@·#$~%&/\¿¸^*¨;•:·_-+'.,".chars + ['.', ' ']
        @term = ANSI.new
    
        @header = data[:header]
        @files = Dir.glob(data[:files])
        @index = 0
        load_slide
        @bye = data[:bye]
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
        @term.clear_screen  
        @slide = File.readlines(@files[@index])
      end
        
      def print_random_char_at(row, col) 
        if rand > 0.3
          text = @pastel.green("#{@eligible_chars.sample} ")
        else
          text = @pastel.green.bold("#{@eligible_chars.sample} ")
        end
        @term.print_text_at(row + 1, col, text)
      end
        
      def print_char_at_ramdom(char)
        return if rand > 0.2
    
        row = rand(@height)
        col = rand(@width)
        text = @pastel.white(char)
        @term.print_text_at(row + 1, col, text)
      end
    
      def show_slide_content
        lines = @slide
        row = (@term.height / 2) - (lines.size / 2)
        max_with = lines.map(&:length).max
        col = (@term.width / 2) - (max_with / 2)
      
        lines.each_with_index do |text, index|
          text = @pastel.white.bold(text)
          @term.print_text_at(row + 1 + index, col,text)
        end
    
        text = " #{@header} (#{@index + 1}/#{@files.count}) "
        @term.print_text_at(1, @term.width - text.length - 1, text)
        text = " q|→|← "
        @term.print_text_at(@term.height - 2, 1, text)
        text = " #{Time.now} "
        @term.print_text_at(@term.height - 2, @term.width - text.length - 1, text)
      end
    end  
  end
end

