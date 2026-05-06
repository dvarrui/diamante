
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
    "#{CODES[:green]}#{text}#{CODES[:reset}"
  end

  def red(text)
    "#{CODES[:red]}#{text}#{CODES[:reset}"
  end

  def yellow(text)
    "#{CODES[:yellow]}#{text}#{CODES[:reset}"
  end
end