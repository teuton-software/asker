# frozen_string_literal: true

require 'rainbow'
require 'rexml/document'
require_relative '../data/concept'
require_relative '../loader/code_loader'
require_relative '../logger'
require_relative '../project'

# Define methods that load data from XML contents
module ContentLoader
  ##
  # Load XML content into Asker data objects
  # @param filepath (String) File path
  # @param content (String) XML plane text content
  def self.load(filepath, content)
    concepts = []
    codes = []

    begin
      xmlcontent = REXML::Document.new(content)
      lang = read_lang_attribute(xmlcontent)
      context = read_context_attribute(xmlcontent)

      xmlcontent.root.elements.each do |xmldata|
        if xmldata.name == 'concept'
          concepts << read_concept(xmldata, filepath, lang, context)
        elsif xmldata.name == 'code'
          codes << read_code(xmldata, filepath)
        else
          Logger.verboseln Rainbow("[ERROR] Unkown input tag <#{xmldata.name}>").red
        end
      end
    rescue REXML::ParseException
      msg = Rainbow('[ERROR] ConceptLoader: Format error in file ').red
      msg += Rainbow(filepath).red.bright
      Logger.verbose msg
      system("echo '#{content}' > output/error.xml")
      raise msg
    end

    { concepts: concepts, codes: codes }
  end

  ##
  # Read lang attr from input XML data
  # @param xmldata (XML Object)
  def self.read_lang_attribute(xmldata)
    begin
      lang = xmldata.root.attributes['lang']
    rescue StandardError
      lang = Project.instance.lang
    end
    lang
  end

  ##
  # Read context attr from input XML data
  # @param xmldata (XML Object)
  def self.read_context_attribute(xmldata)
    begin
      context = xmldata.root.attributes['context']
    rescue StandardError
      context = 'unknown'
    end
    context
  end

  ##
  # Read concept from input XML data
  # @param xmldata (XML Object)
  # @param filepath (String)
  # @param lang
  # @param context
  def self.read_concept(xmldata, filepath, lang, context)
    project = Project.instance
    c = Concept.new(xmldata, filepath, lang, context)
    cond1 = project.process_file == :default
    cond2 = project.process_file == File.basename(filepath)
    c.process = true if cond1 || cond2
    c
  end

  ##
  # Read code from input XML data
  # @param xmldata (XML Object)
  # @param filepath (String)
  def self.read_code(xmldata, filepath)
    project = Project.instance
    f = CodeLoader.new(xmldata, filepath).code
    cond1 = project.process_file == :default
    cond2 = project.process_file == File.basename(filepath)
    f.process = true if cond1 || cond2
    f
  end
end
