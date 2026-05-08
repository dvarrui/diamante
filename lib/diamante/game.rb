# frozen_string_literal: true

require_relative "ansi"
require_relative "config"
require_relative "scenes/scene_factory"

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
          update
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
      scene1 = Scene::SceneFactory.create(@config[:bg])
      scene2 = Scene::SceneFactory.create(@config[:fg])
      scene3 = Scene::SceneFactory.create(@config[:ui])
      scene3.slides = scene2
      @scenes = {
        bg: scene1,
        fg: scene2,
        ui: scene3
      }
    end

    def update
      key = ANSI.pressed_key
          
      case key
      when :up    then puts "↑ Arriba"
      when :down  then puts "↓ Abajo"
      when :left  then
        @scenes[:bg].init
        @scenes[:fg].prev
      when :right then
        @scenes[:bg].init
        @scenes[:fg].next
      when :quit  then deinit
      end

      @scenes.each_value { _1.update }
    end

    def render
      @scenes.each_value { _1.render }
      ANSI.reset_cursor
    end

    def deinit
      ANSI.clear_screen
      ANSI.set_cooked_mode
      puts @config[:game][:bye]
      exit 0
    end
  end
end
