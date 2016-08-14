# encoding: utf-8

require 'erb'
require 'yaml'
require_relative 'text_actions'

class Lang
  include TextActions

  attr_accessor :locale

  def initialize(locale='en')
    @locale = locale.to_s

    dirbase = File.dirname(__FILE__)
    filename=File.join( dirbase, "locales", @locale ,"templates.yaml" )
    begin
      @templates=YAML::load(File.new(filename))
    rescue Exception => e
      Project.instance.verbose "[ERROR] lang.initialize(): Reading YAML file <#{filename}>"
      Project.instance.verbose "[ADVISE] Perhaps you use apostrophe into string without \\ character\n"
      raise e
    end
    filename=File.join( dirbase, "locales", @locale, "connectors.yaml" )
    @connectors=YAML::load(File.new(filename))

    filename=File.join( dirbase, "locales", @locale, "mistakes.yaml" )
    @mistakes=YAML::load(File.new(filename))
  end

  def lang
    @locale
  end

end
