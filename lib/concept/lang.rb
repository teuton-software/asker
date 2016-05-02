# encoding: utf-8

require 'erb'
require 'yaml'
require_relative 'lang/text_actions'

class Lang
  include TextActions
  
  attr_accessor :lang

  def initialize(lang='en')
    @lang=lang.to_s

    d=(__FILE__).split("/")
    d.delete_at(-1)
    dirbase=d.join("/")

    filename=File.join(dirbase, "lang", "locales", @lang ,"templates.yaml" )
    begin
      @templates=YAML::load(File.new(filename))
    rescue Exception => e
      puts filename
      puts e
    end
    filename=File.join( dirbase, "lang", "locales", @lang, "connectors.yaml" )
    @connectors=YAML::load(File.new(filename))

    filename=File.join( dirbase, "lang", "locales", @lang, "mistakes.yaml" )
    @mistakes=YAML::load(File.new(filename))
  end
		
end
