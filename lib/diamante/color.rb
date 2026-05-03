
# Códigos ANSI de color:
# Color	Código	Uso en Ruby
# Rojo	\e[31m	puts "\e[31mEste texto es rojo\e[0m"
# Verde	\e[32m	puts "\e[32mEste texto es verde\e[0m"
# Amarillo	\e[33m	puts "\e[33mEste texto es amarillo\e[0m"
# Reset	\e[0m	(Obligatorio para volver al color normal)

class Color
  RESET = "\e[0m"
  RED = "\e[31m"
  GREEN = "\e[32m"
  YELLOW = "\e[33m"

  def green(text)
    "#{GREEN}#{text}#{RESET}"
  end

  def red(text)
    "#{RED}#{text}#{RESET}"
  end

  def yellow(text)
    "#{YELLOW}#{text}#{RESET}"
  end
end