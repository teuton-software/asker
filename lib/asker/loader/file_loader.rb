# frozen_string_literal: true

require 'haml'
require_relative 'content_loader'

# Methods that load a filename and return list of concepts
module FileLoader
  def self.load(filename)
    if File.extname(filename).casecmp('.haml').zero?
      file_content = load_haml filename
    elsif File.extname(filename).casecmp('.xml').zero?
      file_content = open(filename, &:read)
    else
      msg = "[ERROR] FileLoader: Format error #{filename}"
      Project.instance.verbose msg
      raise msg
    end

    data = ContentLoader.new(filename, file_content).load
    data
  end

  def self.load_haml(filename)
    template = File.read(filename)
    haml_engine = Haml::Engine.new(template)
    haml_engine.render
  end
end
