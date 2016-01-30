# encoding: utf-8

require 'erb'
require 'yaml'
require_relative 'lang/text_actions'

class Lang
  include TextActions
  
  attr_accessor :lang

  def initialize(lang='en')
    @lang=lang

    d=(__FILE__).split("/")
    d.delete_at(-1)
    dirbase=d.join("/")

    filename=File.join(dirbase, "lang", "locales", lang ,"templates.yaml" )
    @templates=YAML::load(File.new(filename))

    filename=File.join( dirbase, "lang", "locales", lang, "connectors.yaml" )
    @connectors=YAML::load(File.new(filename))

    filename=File.join( dirbase, "lang", "locales", lang, "mistakes.yaml" )
    @mistakes=YAML::load(File.new(filename))
  end
		
end
