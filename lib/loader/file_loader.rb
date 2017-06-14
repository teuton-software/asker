# encoding: utf-8

require 'haml'
require_relative 'content_loader'

# Methods that load a filename and return list of concepts
class FileLoader

  def initialize(filename)
    @filename = filename
    @concepts = []
  end

  def load
    project = Project.instance

    if File.extname(@filename).casecmp('.haml').zero?
      template = File.read(@filename)
      haml_engine = Haml::Engine.new(template)
      file_content = haml_engine.render
    elsif File.extname(@filename).casecmp('.xml').zero?
      file_content = open(@filename) { |i| i.read }
    else
      msg = "[ERROR] FileLoader: Format error #{@filename}"
      project.verbose msg
      raise msg
    end

    @concepts = ContentLoader.new(@filename, file_content).load
    @concepts
  end
end
