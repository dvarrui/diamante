require "pastel"
require "yaml"

module Matrix
  class Slider
    attr_reader :bye
    attr_reader :index
  
    def initialize(configfile)
      data = YAML.load(File.read configfile)
      @pastel = Pastel.new
      @eligible_chars = "ª\|@·#$~%&/\¿¸^*¨;•:·_-+'.,".chars + ['.', ' ']
      @height, @width = `stty size`.split.map { _1.to_i }
  
      @header = " #{data[:header]} "
      @bye = data[:bye]
      @files = Dir.glob(data[:files])
      set_index 0
    end
  
    def game_loop
      loop do
        show
        sleep 0.1
      end
    end

    def show
      @chars[rand(@width)] = 0
  
      @chars.each do |col, row|
        @chars[col] += 1
        print_random_char_at(row, col)
      end
      print_char_at_ramdom("•")
      show_slide_content
    end

    def set_index(index)
      @index = index
      @chars = {}
      clear_screen  
      @slide = File.readlines(@files[@index])
    end
  
    private
  
    def clear_screen
      print "\e[2J\e[H"
    end
  
    def move_cursor(row, col)
      print "\033[#{row};#{col}H"
    end
  
    def reset_cursor
      print "\e[H"
    end
    
    def print_random_char_at(row, col) 
      move_cursor(row + 1, col)
      if rand > 0.3
        print @pastel.green("#{@eligible_chars.sample} ")
      else
        print @pastel.green.bold("#{@eligible_chars.sample} ")
      end
      reset_cursor
    end
  
    def print_text_at(row, col, text) 
      move_cursor(row + 1, col)
      print @pastel.white(text)
      reset_cursor
    end
  
    def print_char_at_ramdom(char)
      return if rand > 0.2
  
      row = rand(@height)
      col = rand(@width)
      move_cursor(row + 1, col)
      print @pastel.white(char)
      reset_cursor
    end
  
    def show_slide_content
      lines = @slide
      row = (@height / 2) - (lines.size / 2)
      max_with = lines.map(&:length).max
      col = (@width / 2) - (max_with / 2)
    
      lines.each_with_index do |text, index|
        print "\033[#{row + 1 + index};#{col}H"
        print @pastel.white.bold(text)
        print "\033[0;0H"
      end
  
      print_text_at(1, @width - @header.length - 1, @header)
      text = " #{@index + 1}/#{@files.count} "
      print_text_at(@height - 2, 1, text)
      hour = " #{Time.now} "
      print_text_at(@height - 2, @width - hour.length - 1, hour)
    end
  end  
end

