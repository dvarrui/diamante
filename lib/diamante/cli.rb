# frozen_string_literal: true

require "thor"
require_relative "../diamante"

class CLI < Thor
  map ["-h", "--help"] => "help"

  map ["-v", "--version"] => "version"
  desc "version", "Show the program version"
  def version
    puts "diamante version #{Diamante::VERSION}"
    exit 0
  end

  map ["n", "-n", "--new"] => "new"
  desc "new", "Create new project"
  def new(dirpath)
    Diamante.new(dirpath)
  end

  map ["r", "-r", "--restart"] => "restart"
  desc "restart", "Restart ANSI terminal"
  def restart
    require 'io/console'

    STDIN.cooked!
    STDIN.echo = true
  end

  map ["s", "-s", "--show"] => "show"
  desc "show PATH/TO/FILE", "Show slides (from YAML or MD file)"
  def show(filepath)
    Diamante::show(filepath)
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
