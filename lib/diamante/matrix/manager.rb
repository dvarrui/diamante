
require 'io/console'
require_relative "slider"

module Matrix
  class Manager
    STDIN.echo = false
    STDIN.raw!

    def initialize(configfile)
      @slider = Slider.new(configfile)
    end

    def call
      index = 0
      begin
        loop do
          key = get_input
          
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
        STDIN.cooked!
        STDIN.echo = true
      end
    end


    private

    def get_input
      char = STDIN.read_nonblock(3) rescue nil
      return nil unless char
    
      case char
      when "\e[A" then :up
      when "\e[B" then :down
      when "\e[C" then :right
      when "\e[D" then :left
      when "q"    then :quit
      else char
      end
    end
    
  end
end

