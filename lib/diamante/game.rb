
require_relative "ansi"
require_relative "scenes/slides"

module Diamante
  class Game
    def initialize(configfile)
      @term = ANSI.new
      @scene = Scene::Slides.new(configfile)
    end

    def game_loop
      begin
        init
        loop do
          process
          render
          sleep 0.1
        end
        deinit
      ensure
        ANSI.set_cooked_mode
      end
    end

    private

    def init
      ANSI.set_raw_mode
    end

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
      ANSI.set_cooked_mode
      exit 0
    end
  end
end

