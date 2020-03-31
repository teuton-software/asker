# frozen_string_literal: true

require 'haml'

# HAML file loader
module HamlLoader
  ##
  # Load HAML file name
  # @param filename (String) HAML file name
  def self.load(filename)
    template = File.read(filename)
    haml_engine = Haml::Engine.new(template)
    haml_engine.render
  end
end
