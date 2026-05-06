require "io/console"

# Códigos ANSI de color:
# Color	Código	Uso en Ruby
# Rojo	\e[31m	puts "\e[31mEste texto es rojo\e[0m"
# Verde	\e[32m	puts "\e[32mEste texto es verde\e[0m"
# Amarillo	\e[33m	puts "\e[33mEste texto es amarillo\e[0m"
# Reset	\e[0m	(Obligatorio para volver al color normal)

class ANSI
  COLORS = {
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m"
  }
  RESET = "\e[0m"
  CLEAR_SCREEN = "\e[2J\e[H"

  attr_reader :height, :width

  def initialize
    @height, @width = `stty size`.split.map { _1.to_i }
  end

  def green(text)
    print_with_color(:green, text)
  end

  def red(text)
    print_with_color(:red, text)
  end

  def yellow(text)
    print_with_color(:yellow, text)
  end

  def print_wiht_color(color, text)
    "#{COLORS[color]}#{text}#{RESET}"
  end

  def clear_screen
    print CLEAR_SCREEN
  end

  def move_cursor(row, col)
    print "\033[#{row};#{col}H"
  end

  def reset_cursor
    print RESET
  end

  def print_text_at(row, col, text) 
    move_cursor(row + 1, col)
    print text
    reset_cursor
  end

  def pressed_key
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

  def set_raw_mode
    STDIN.echo = false
    STDIN.raw!
  end

  def set_cooked_mode
    STDIN.cooked!
    STDIN.echo = true
  end
end