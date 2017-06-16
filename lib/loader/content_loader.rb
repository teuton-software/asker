# encoding: utf-8

require 'rainbow'
require 'rexml/document'
require_relative '../data/concept'
require_relative '../loader/fob_loader'

# Define methods that load data from XML contents
class ContentLoader
  def initialize(filename, xml_content)
    @filename = filename
    @content = xml_content
    @concepts = []
    @fobs = []
    @data = {}
  end

  def load
    project = Project.instance

    begin
      lxmldata = REXML::Document.new(@content)
      lang = read_lang_attribute(lxmldata)
      context = read_context_attribute(lxmldata)

      lxmldata.root.elements.each do |xmldata|
        if xmldata.name == 'concept'
          c = Concept.new(xmldata, @filename, lang, context)
          cond1 = project.process_file == :default
          cond2 = project.process_file == File.basename(@filename)
          c.process = true if cond1 || cond2
          @concepts << c
        elsif xmldata.name == 'file'
          cond1 = project.process_file == :default
          cond2 = project.process_file == File.basename(@filename)
          if cond1 || cond2
            f = FOBLoader.new(xmldata, @filename).fob
            f.debug
            @fobs << f
          end
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

    @data[:concepts] = @concepts
    @data[:fobs] = @fobs
    @data
  end

  private

  def read_lang_attribute(lxmldata)
    begin
      lang = lxmldata.root.attributes['lang']
    rescue
      lang = Project.instance.lang
    end
    lang
  end

  def read_context_attribute(lxmldata)
    begin
      context = lxmldata.root.attributes['context']
    rescue
      context = 'unknown'
    end
    context
  end
end
