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

    if @filename[-5..-1]==".haml" then
      template = File.read(@filename)
      haml_engine = Haml::Engine.new(template)
      lFileContent = haml_engine.render
    else
      lFileContent=open(@filename) { |i| i.read }
    end

    @concepts = ContentLoader.new(@filename, lFileContent).load

    return @concepts
  end

end
