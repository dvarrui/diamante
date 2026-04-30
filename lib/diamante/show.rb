
module Diamante
  class Show
    def initialize(filename)
      @filename = filename
    end
  
    def call
      puts "==> show #{@filename}"
    end
  
    private
  
    def load(filename)
  
    end
  end
end

