# frozen_string_literal: true

require "pastel"
require_relative "../ansi"
require_relative "slides"

module Diamante
  module Scene
    class UI
      attr_accessor :slides

      def initialize(config)
        @pastel = Pastel.new
    
        @header = config[:header]
        @slides = slides
        @term = ANSI.new
        @height = @term.height
        @width = @term.width
      end
      
      def render
        text = " #{@header} (#{@slides.index + 1}/#{@slides.count}) "
        col = @width - text.length - 1
        text = @pastel.white(text)
        ANSI.print_text_at(1, col, text)
        text = " q|→|← "
        text = @pastel.white(text)
        ANSI.print_text_at(@height - 2, 1, text)
        text = " #{Time.now} "
        col = @width - text.length - 1
        text = @pastel.white(text)
        ANSI.print_text_at(@height - 2, col, text)
      end
    end  
  end
end

