
# Códigos ANSI de color:
# Color	Código	Uso en Ruby
# Rojo	\e[31m	puts "\e[31mEste texto es rojo\e[0m"
# Verde	\e[32m	puts "\e[32mEste texto es verde\e[0m"
# Amarillo	\e[33m	puts "\e[33mEste texto es amarillo\e[0m"
# Reset	\e[0m	(Obligatorio para volver al color normal)

module ANSI
  CODES = {
    reset: "\e[0m",
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m"
  }

  def self.green(text)
    self.color(:green, text)
  end

  def self.red(text)
    self.color(:red, text)
  end

  def self.yellow(text)
    self.color(:yellow, text)
  end

  def self.color(color, text)
    "#{CODES[color]}#{text}#{CODES[:reset]}"
  end

  def self.clear_screen
    print "\e[2J\e[H"
  end

  def self.move_cursor(row, col)
    print "\033[#{row};#{col}H"
  end

  def self.reset_cursor
    print "\e[H"
  end

  def self.print_text_at(row, col, text) 
    ANSI.move_cursor(row + 1, col)
    # print @pastel.white(text)
    print text
    ANSI.reset_cursor
  end

end