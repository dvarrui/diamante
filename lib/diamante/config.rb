# frozen_string_literal: true

require "yaml"

module Diamante
  class Config
    def initialize(configfile)
      @data = YAML.load(File.read configfile)
      # @data[:eligible_chars] = "ª\|@·#$~%&/\¿¸^*¨;•:·_-+'.,".chars + ['.', ' ']
    end

    def [](key)
      @data[key]
    end
  end
end