
require_relative "ansi"
require_relative "slider/matrix"

module Diamante
  class Game
    def initialize(configfile)
      @slider = Slider::Matrix.new(configfile)
      ANSI.set_terminal_raw_mode
    end

    def run
      begin
        loop do
          key = ANSI.pressed_key
          
          case key
          when :up    then puts "↑ Arriba"
          when :down  then puts "↓ Abajo"
          when :left  then @slider.prev
          when :right then @slider.next
          when :quit  then break
          end
          @slider.show          
          sleep 0.1
        end
      ensure
        ANSI.set_terminal_cooked_mode
      end
    end
  end
end

