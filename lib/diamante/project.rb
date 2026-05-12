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
        puts "[Project.new] No file!! #{source_file}"
      end
      puts "... INFO: Customize the value of <fg/files> param!"
    rescue StandardError => e
      puts "[Project.new] #{e.message}"
    end
  end
end
