# encoding: utf-8

require 'haml'
require_relative 'content_loader'

class FileLoader

  def initialize(filename)
    @filename  = filename
    @concepts = {}
  end

  def load
    project=Project.instance

    if File.extname(@filename).downcase==".haml" then
      template = File.read(@filename)
      haml_engine = Haml::Engine.new(template)
      lFileContent = haml_engine.render
    elsif File.extname(@filename).downcase==".xml" then
      lFileContent=open(@filename) { |i| i.read }
    else
      msg = "[ERROR] FileLoader: Format error "+@filename.to_s
      Project.instance.verbose msg
      raise msg
    end

    @concepts = ContentLoader.new(@filename, lFileContent).load
    return @concepts
  end

end
