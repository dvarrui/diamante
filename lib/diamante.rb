# frozen_string_literal: true

require_relative "diamante/md/markdown"
require_relative "diamante/version"

module Diamante

  def self.show_from_markdown(filepath)
    Markdown.new(filepath).show
  end

  def self.show_from_yaml(filepath)
    require_relative "diamante/manager"
    Manager.new(filepath).call
  end
end
