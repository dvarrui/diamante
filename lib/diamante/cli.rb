# frozen_string_literal: true

require "thor"
require_relative "version"
require_relative "../diamante"

class CLI < Thor
  map ["-h", "--help"] => "help"

  map ["-v", "--version"] => "version"
  desc "version", "Show the program version"
  def version
    puts "diamante version #{Diamante::VERSION}"
    exit 0
  end

  map ["s", "-s", "--show"] => "show"
  option :color, type: :boolean
  desc "[show] FILEPATH", "Show slides"
  long_desc <<-LONGDESC

  LONGDESC
  def show(filename)
    Diamante::show(filename)
  end

  def method_missing(method, *_args, &_block)
    show(method.to_s)
  end

  def respond_to_missing?(_method_name)
    true
  end

  ##
  # Thor stop and show messages on screen on failure
  def self.exit_on_failure?
    true
  end
end
