require_relative "parser"

module Diamante
  class Show  
    def self.call(filepath)
      sections = Parser.call(filepath)
      show(sections)
    end
  
    private
  
    def self.show(sections)
      sections.each do |title, blocks|
        puts "--- SECTION: #{title} ---"
        blocks.each do |b|
          case b.type
          when :p
            text = ""
            b.children.each do |item|
              if item.type == :codespan
                text += "<#{item.value}>"
              else
                text += item.value
              end
            end
            puts text
            when :ul
            b.children.each do |li|
              text = li.children.first.children.first.value
              puts "* #{text}"
            end
          when :blank
            # nothing
          else
            print "[Block type: #{b.type}] "
            pp b.inspect
          end
        end
        puts "\n"
      end  
    end
  end
end

