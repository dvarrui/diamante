# frozen_string_literal: true

require_relative "ansi"
require_relative "config"
require_relative "scenes/matrix"
require_relative "scenes/slides"
require_relative "scenes/ui"

module Diamante
  class Game
    def initialize(configfile)
      @term = ANSI.new
      @config = Config.new(configfile)
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
      scene1 = Scene::Matrix.new(@config)
      scene2 = Scene::Slides.new(@config)
      scene3 = Scene::UI.new(@config[:header], scene2)
      @scenes = {
        bg: scene1,
        slides: scene2,
        ui: scene3
      }
    end

    def process
      key = ANSI.pressed_key
          
      case key
      when :up    then puts "↑ Arriba"
      when :down  then puts "↓ Abajo"
      when :left  then @scenes[:slides].prev
      when :right then @scenes[:slides].next
      when :quit  then deinit
      end
    end

    def render
      @scenes.each_value { _1.render }
      ANSI.reset_cursor
    end

    def deinit
      ANSI.clear_screen
      ANSI.set_cooked_mode
      puts @config[:bye]
      exit 0
    end
  end
end

