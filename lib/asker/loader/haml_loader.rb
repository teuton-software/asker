# frozen_string_literal: true

require 'haml'

# HAML file loader
module HamlLoader
  def self.load(filename)
    template = File.read(filename)
    begin
      haml_engine = Haml::Engine.new(template)
      return haml_engine.render
    rescue StandardError => e
      puts "[ERROR] HamlLoader: Can't load <#{filename}> file!"
      puts "  => #{e}"
      exit 0
    end
  end

end
