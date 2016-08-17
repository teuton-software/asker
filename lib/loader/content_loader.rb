# encoding: utf-8

require 'rainbow'
require 'rexml/document'
require_relative '../data/concept'

class ContentLoader

  def initialize(filename, xml_content)
    @filename  = filename
    @content = xml_content
    @concepts = []
  end

  def load
    project=Project.instance

    begin
      lXMLdata=REXML::Document.new(@content)
        begin
        lLang=lXMLdata.root.attributes['lang']
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
          @concepts << c
        end
      end
    rescue REXML::ParseException
      msg = Rainbow("[ERROR] ConceptLoader: Format error in file ").red+Rainbow(@filename).red.bright
      project.verbose msg
      system("echo '#{lFileContent}' > output/error.xml")
      raise msg
    end

    return @concepts
  end

end
