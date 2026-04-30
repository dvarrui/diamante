#!/usr/bin/env ruby

require "kramdown"
require "debug"

markdown_text = <<~MARKDOWN
  # Introducción

  Este es el primer párrafo.
  
  # Requisitos

  * Ruby 3.0+
  * Kramdown Gem
  
  # Instalación

  Ejecuta `gem install kramdown`.
MARKDOWN

doc = Kramdown::Document.new(markdown_text)
root = doc.root

sections = {}
title = ""
root.children.each do |elem|
  if elem.type == :header
    title = elem.options[:raw_text] || "Sin título"
    sections[title] = []
  else
    sections[title] << elem
  end
end


sections.each do |title, blocks|
  puts "--- SECCIÓN: #{title} ---"
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
      print "[Bloque tipo: #{b.type}] "
      pp b.inspect
    end
  end
  puts "\n"
end