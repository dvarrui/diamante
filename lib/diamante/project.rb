# frozen_string_literal: true
require 'fileutils'

module Diamante
  class Project
    def self.new(dirpath)
      puts "==> Creating new project"

      FileUtils.mkdir_p(dirpath)
      puts "--> Create dir  : #{dirpath}"

      source_file = File.join(__dir__, 'files', 'config.yaml')
      if File.exist?(source_file)
        FileUtils.cp(source_file, dirpath)
        puts "--> Create file : #{dirpath}/config.yaml"
      else
        puts "Error: El archivo no existe en la ruta esperada: #{source_file}"
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end