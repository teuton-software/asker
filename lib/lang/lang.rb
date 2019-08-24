# encoding: utf-8

require 'erb'
require 'yaml'
require_relative 'text_actions'

class Lang
  include TextActions

  attr_reader :code, :mistakes

  def initialize(code='en')
    @code = code.to_s
    load_files
  end

  def lang
    @code
  end

private

  def load_files
    dirbase = File.dirname(__FILE__)
    filename = File.join(dirbase, 'locales', @code, 'templates.yaml')
    begin
      @templates=YAML::load(File.new(filename))
    rescue Exception => e
      Project.instance.verbose "[ERROR] lang.initialize(): Reading YAML file <#{filename}>"
      Project.instance.verbose "[ADVISE] Perhaps you use apostrophe into string without \\ character\n"
      raise e
    end
    filename = File.join(dirbase, 'locales', @code, 'connectors.yaml')
    @connectors = YAML::load(File.new(filename))

    filename = File.join(dirbase, 'locales', @code, 'mistakes.yaml')
    @mistakes = YAML::load(File.new(filename))
  end

end
