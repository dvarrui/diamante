# frozen_string_literal: true

require "pastel"
require_relative "../ansi"
require_relative "slides"

module Diamante
  module Scene
    class UI
      def initialize(header, slides)
        @pastel = Pastel.new
    
        @header = header
        @slides = slides
        @term = ANSI.new
        @height = @term.height
        @white = @term.width
      end
      
      def render
        text = " #{@header} (#{@slides.index + 1}/#{@slides.count}) "
        ANSI.print_text_at(1, @width - text.length - 1, text)
        text = " q|→|← "
        ANSI.print_text_at(@height - 2, 1, text)
        text = " #{Time.now} "
        ANSI.print_text_at(@height - 2, @width - text.length - 1, text)
      end
    end  
  end
end

