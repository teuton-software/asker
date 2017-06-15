# encoding: utf-8

require 'rainbow'
require 'rexml/document'
require_relative '../data/concept'

# Define methods that load data from XML contents
class ContentLoader
  def initialize(filename, xml_content)
    @filename = filename
    @content = xml_content
    @concepts = []
  end

  def load
    project = Project.instance

    begin
      lxmldata = REXML::Document.new(@content)
      begin
        lLang = lxmldata.root.attributes['lang']
        lContext = lxmldata.root.attributes['context']
      rescue
        lLang = project.lang
        lContext = 'unknown'
      end

      lxmldata.root.elements.each do |xmldata|
        if xmldata.name == 'concept'
          c = Concept.new(xmldata, @filename, lLang, lContext)
          if (project.process_file == :default || project.process_file == File.basename(@filename))
            c.process = true
          end
          @concepts << c
        elsif xmldata.name == 'file'
          puts Rainbow('[DEBUG] <FILE> tag found!').yellow
        else
          puts Rainbow("[ERROR] Tag error <#{xmldata.name}>").red
        end
      end
    rescue REXML::ParseException
      msg = Rainbow('[ERROR] ConceptLoader: Format error in file ').red
      msg += Rainbow(@filename).red.bright
      project.verbose msg
      system("echo '#{@content}' > output/error.xml")
      raise msg
    end

    @concepts
  end
end
