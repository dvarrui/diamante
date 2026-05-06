
require_relative "ansi"
require_relative "scenes/matrix"

module Diamante
  class Game
    def initialize(configfile)
      @term = ANSI.new
      @scene = Slider::Matrix.new(configfile)
      @term.set_raw_mode
    end

    def game_loop
      begin
        loop do
          process
          render
          sleep 0.1
        end
      ensure
        @term.set_cooked_mode
      end
    end

    private

    def process
      key = @term.pressed_key
          
      case key
      when :up    then puts "↑ Arriba"
      when :down  then puts "↓ Abajo"
      when :left  then @scene.prev
      when :right then @scene.next
      when :quit  then deinit
      end
    end

    def render
      @scene.render
    end

    def deinit
      @term.set_cooked_mode
      exit 0
    end
  end
end

