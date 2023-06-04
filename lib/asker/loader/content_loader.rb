require "rexml/document"
require_relative "code_loader"
require_relative "problem_loader"
require_relative "../data/concept"
require_relative "../data/project_data"
require_relative "../lang/lang_factory"
require_relative "../logger"

module ContentLoader
  ##
  # Load XML content into Asker data objects
  # @param filepath (String) File path
  # @param content (String) XML plane text content
  def self.call(filepath, content)
    begin
      xmlcontent = REXML::Document.new(content)
    rescue REXML::ParseException
      raise_error_with(filepath, content)
    end
    codes = []
    concepts = []
    problems = []
    lang = read_lang_attribute(xmlcontent)
    context = read_context_attribute(xmlcontent)

    xmlcontent.root.elements.each do |xmldata|
      case xmldata.name
      when "code"
        codes << read_code(xmldata, filepath)
      when "concept"
        concepts << read_concept(xmldata, filepath, lang, context)
      when "problem"
        problems << read_problem(xmldata, filepath, lang, context)
      else
        Logger.warn "ContentLoader: Unkown tag (#{xmldata.name}) Use concept, code or problem."
      end
    end

    {concepts: concepts, codes: codes, problems: problems}
  end

  private_class_method def self.read_lang_attribute(xmldata)
    begin
      lang_code = xmldata.root.attributes["lang"]
    rescue itself
      lang_code = ProjectData.instance.lang
      Logger.warn "ContentLoader: Applying default lang (#{lang_code})"
    end
    LangFactory.instance.get(lang_code)
  end

  private_class_method def self.read_context_attribute(xmldata)
    begin
      context = xmldata.root.attributes["context"].split(",")
      context.collect!(&:strip)
    rescue itself
      context = ["unknown"]
      Logger.warn "ContentLoader: Context is empty!"
    end
    context
  end

  private_class_method def self.read_code(xmldata, filepath)
    project = ProjectData.instance
    c = CodeLoader.call(xmldata, filepath)
    c.process = true if [File.basename(filepath), :default].include? project.get(:process_file)
    c
  end

  private_class_method def self.read_concept(xmldata, filepath, lang, context)
    project = ProjectData.instance
    c = Concept.new(xmldata, filepath, lang, context)
    c.process = true if [File.basename(filepath), :default].include? project.get(:process_file)
    c
  end

  private_class_method def self.read_problem(xmldata, filepath, lang, context)
    project = ProjectData.instance
    p = ProblemLoader.new(lang, context).call(xmldata, filepath)
    p.process = true if [File.basename(filepath), :default].include? project.get(:process_file)
    p
  end

  private_class_method def self.raise_error_with(filepath, content)
    Logger.error "ContentLoader: Format error (#{filepath})"
    Logger.error "             : Revise output file (ouput/error.xml)"
    f = File.open("output/error.xml", "w")
    f.write(content)
    f.close
    raise msg
  end
end
