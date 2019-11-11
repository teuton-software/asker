# encoding: utf-8

require 'rainbow'
require 'rexml/document'
require_relative '../data/concept'
require_relative '../loader/code_loader'

# Define methods that load data from XML contents
class ContentLoader
  def initialize(filepath, xml_content)
    @filepath = filepath
    @content = xml_content
    @concepts = []
    @codes = []
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
          c = Concept.new(xmldata, @filepath, lang, context)
          cond1 = project.process_file == :default
          cond2 = project.process_file == File.basename(@filepath)
          c.process = true if cond1 || cond2
          @concepts << c
        elsif xmldata.name == 'code'
          f = CodeLoader.new(xmldata, @filepath).code
          cond1 = project.process_file == :default
          cond2 = project.process_file == File.basename(@filepath)
          f.process = true if cond1 || cond2
          @codes << f
        else
          puts Rainbow("[ERROR] Unkown input tag <#{xmldata.name}>").red
        end
      end
    rescue REXML::ParseException
      msg = Rainbow('[ERROR] ConceptLoader: Format error in file ').red
      msg += Rainbow(@filepath).red.bright
      project.verbose msg
      system("echo '#{@content}' > output/error.xml")
      raise msg
    end

    @data[:concepts] = @concepts
    @data[:codes] = @codes
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
