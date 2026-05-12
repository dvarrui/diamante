# frozen_string_literal: true

require_relative "diamante/md/markdown"
require_relative "diamante/project"
require_relative "diamante/version"

module Diamante

  def self.new(dirpath)
    Project.new(dirpath)
  end

  def self.show(filepath)
    if filepath.end_with? ".md"
      Markdown.new(filepath).show
    elsif filepath.end_with? ".yaml"
      require_relative "diamante/game"
      Game.new(filepath).game_loop
    else
      warn "[ERROR] Unknown type! (#{filepath})"
      exit 1
    end
  end
end
