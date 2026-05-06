
require_relative "ansi"
require_relative "slider/matrix"

module Diamante
  class Game
    def initialize(configfile)
      @scene = Slider::Matrix.new(configfile)
      ANSI.set_terminal_raw_mode
    end

    def game_loop
      begin
        loop do
          process
          render
          sleep 0.1
        end
      ensure
        ANSI.set_terminal_cooked_mode
      end
    end

    private

    def process
      key = ANSI.pressed_key
          
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
      ANSI.set_terminal_cooked_mode
      exit 0
    end
  end
end

