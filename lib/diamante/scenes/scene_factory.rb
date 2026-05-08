require_relative "matrix"
require_relative "slides"
require_relative "space"
require_relative "ui"

module Diamante
  module Scene
    class SceneFactory
      def self.create(config)
        klass_name = config[:scene]

        case klass_name
        when "Matrix" then return Matrix.new(config)
        when "Slides" then return Slides.new(config)
        when "Space" then return Space.new(config)
        when "UI" then return UI.new(config)
        else
          warn "[SceneFactory] Unkown scene! (#{klass_name})"
          exit 1
        end
      end
    end
  end
end

