# encoding: utf-8

require 'haml'
require 'rexml/document'

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

    begin
      lXMLdata=REXML::Document.new(lFileContent)
      #system("echo '#{lFileContent}' > output/#{f}.xml")
      begin
        lLang=lXMLdata.root.attributes['lang'] # has lang attribute or not?
        lContext=lXMLdata.root.attributes['context']
      rescue
        lLang=project.lang
        lContext="unknown"
      end

      lXMLdata.root.elements.each do |xmldata|
        if xmldata.name=='concept' then
          c=Concept.new(xmldata, @filename, lLang, lContext)
          if ( project.process_file==:default or project.process_file== File.basename(@filename) ) then
            c.process=true
          end
          @concepts[c.name]=c
        end
      end
    rescue REXML::ParseException
      msg = Rainbow("[ERROR] FileLoader: Format error in file ").red+Rainbow(@filename).red.bright
      project.verbose msg
      system("echo '#{lFileContent}' > output/error.xml")
      raise msg
    end

    return @concepts
  end

end
