# frozen_string_literal: true

require 'haml'
require_relative 'content_loader'
require_relative '../logger'

# Methods that load a filename and return list of concepts
module FileLoader
  ##
  # Load asker data from file
  # @param filename (String) File name to be load
  def self.load(filename)
    if File.extname(filename).casecmp('.haml').zero?
      file_content = load_haml filename
    elsif File.extname(filename).casecmp('.xml').zero?
      file_content = File.read(filename)
    else
      msg = "[ERROR] FileLoader: Format error #{filename}"
      Logger.verbose msg
      raise msg
    end
    ContentLoader.load(filename, file_content)
  end

  ##
  # Load HAML file name
  # @param filename (String) HAML file name
  def self.load_haml(filename)
    template = File.read(filename)
    haml_engine = Haml::Engine.new(template)
    haml_engine.render
  end
end
