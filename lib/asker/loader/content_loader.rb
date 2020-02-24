# frozen_string_literal: true

require 'rainbow'
require 'rexml/document'
require_relative '../data/concept'
require_relative 'code_loader'
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
    rescue REXML::ParseException
      raise_error_with(filepath, content)
    end
    lang = read_lang_attribute(xmlcontent)
    context = read_context_attribute(xmlcontent)

    xmlcontent.root.elements.each do |xmldata|
      case xmldata.name
      when 'concept'
        concepts << read_concept(xmldata, filepath, lang, context)
      when 'code'
        codes << read_code(xmldata, filepath)
      else
        Logger.verboseln Rainbow("[ERROR] Unkown tag <#{xmldata.name}>").red
      end
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
    if [ File.basename(filepath), :default ].include? project.process_file
      c.process = true
    end
    c
  end

  ##
  # Read code from input XML data
  # @param xmldata (XML Object)
  # @param filepath (String)
  def self.read_code(xmldata, filepath)
    project = Project.instance
    c = CodeLoader.load(xmldata, filepath)
    if [ File.basename(filepath), :default ].include? project.process_file
      c.process = true
    end
    c
  end

  def self.raise_error_with(filepath, content)
    msg = Rainbow("[ERROR] ContentLoader: Format error in #{filepath}").red.bright
    Logger.verbose msg
    f = File.open('output/error.xml', 'w')
    f.write(content)
    f.close
    raise msg
  end
end
