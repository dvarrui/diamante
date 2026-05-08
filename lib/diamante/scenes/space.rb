# frozen_string_literal: true

require "pastel"
require_relative "base"
require_relative "../ansi"

module Diamante
  module Scene
    class Space < Base
      def initialize(config)
        @config = config
        @chars_list = "-O "
        init
      end
      
      def init
        @stars = []
        5.times { @stars << Star.new }
      end

      def update
        @stars.each { _1.render }
      end

      def render
        @stars.each { _1.update }
      end
        
      private 

      class Star
        attr_reader :char
        attr_reader :x
        attr_reader :y

        def initialize
          @pastel = Pastel.new
          @term = ANSI.new
          @char = @pastel.white.bold("*")
          @x = 0
          @y = 0
          init
        end

        def init
          @last_y = @y
          @last_x = @x
          @y = rand(@term.height).to_f
          @x = rand(@term.width).to_f
          @speed = rand * 0.000000001
        end

        def update
          sleep 0.1
          @last_y = @y
          @last_x = @x
          @x += @x + @speed * 0.000000000001
          if @x >= @term.width
            ANSI.print_text_at(@last_y.to_i, @last_x.to_i + 1, " ")
            @y = rand(@term.height).to_f
            @x = 0
            @speed = rand * 0.00000001
          end
        end

        def render
          return if (@x - @last_x + @y - @last_y).zero?
          ANSI.print_text_at(@last_y.to_i, @last_x.to_i + 1, " ")
          text = @pastel.white.bold(@char)
          ANSI.print_text_at(@y.to_i, @x.to_i + 1, text)
        end
      end
    end  
  end
end

