# frozen_string_literal: true

require_relative "ansi"
require_relative "config"
require_relative "scenes/ui"
require_relative "scenes/slides"

module Diamante
  class Game
    def initialize(configfile)
      @term = ANSI.new
      @config = Config.new(configfile)
      @scenes = {}
      @scene_slides = Scene::Slides.new(@config)
      @scene_ui = Scene::UI.new(@config[:header], @scene_slides)
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
      when :left  then @scene_slides.prev
      when :right then @scene_slides.next
      when :quit  then deinit
      end
    end

    def render
      @scene_slides.render
      @scene_ui.render
    end

    def deinit
      ANSI.clear_screen
      # puts bye
      ANSI.set_cooked_mode
      exit 0
    end
  end
end

