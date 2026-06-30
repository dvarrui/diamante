# frozen_string_literal: true

require "pastel"
require_relative "base"
require_relative "../ansi"

module Diamante
  module Scene
    class Slides < Base
      attr_reader :index
    
      def initialize(config)
        @config = config
        @pastel = Pastel.new
        @term = ANSI.new
        @height = @term.height
        @width = @term.width

        @files = Dir.glob(@config[:files])
        if @files.empty?
          ANSI.set_cooked_mode
          warn "[ERROR] No slides! Revise config.yaml"
          exit 1
        end
        @index = 0
        load_slide
      end
      
      def count
        @files.count
      end

      def render
        lines = @slide
        row = (@height / 2) - (lines.size / 2)
        max_with = lines.map(&:length).max || 0
        col = (@width / 2) - (max_with / 2)
      
        lines.each_with_index do |text, index|
          text = @pastel.white.bold(text)
          ANSI.print_text_at(row + 1 + index, col,text)
        end
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
        if @files[@index].nil?
          @slide = "Undefined!"
        else
          @slide = File.readlines(@files[@index])
        end
      end
    end  
  end
end

