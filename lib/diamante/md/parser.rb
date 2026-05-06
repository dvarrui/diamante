require "kramdown"

module Diamante
  class Parser
    def self.call(filepath)
      parse(load(filepath))
    end

    private

    def self.load(filepath)
      content = File.read(filepath)
      doc = Kramdown::Document.new(content)
      root = doc.root
    end

    def self.parse(root)
      sections = {}
      title = :init
      root.children.each do |elem|
        if elem.type == :header
          title = elem.options[:raw_text] || "Sin título"
          sections[title] = []
        elsif title == :init
          # nothing
          # pp elem
        else
          sections[title] << elem
        end
      end
      sections
    end
  end
end

