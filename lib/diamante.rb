# frozen_string_literal: true

require_relative "diamante/show"
require_relative "diamante/version"

module Diamante
  class Error < StandardError; end
  # Your code goes here...

  def self.show(filepath)
    Show.call(filepath)
  end
end
