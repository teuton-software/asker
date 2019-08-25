# frozen_string_literal: true

require 'erb'
require 'yaml'
require_relative 'text_actions'

# Lang#lang
class Lang
  include TextActions

  attr_reader :code, :mistakes

  def initialize(code = 'en')
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
      @templates = YAML.load(File.new(filename))
    rescue StandardError => e
      p = Project.instance
      p.vervose "[ERROR] lang.initialize(): Reading YAML file <#{filename}>"
      p.vervose "[ADVISE] Revise apostrophe into string without \\ char\n"
      raise e
    end
    filename = File.join(dirbase, 'locales', @code, 'connectors.yaml')
    @connectors = YAML.load(File.new(filename))

    filename = File.join(dirbase, 'locales', @code, 'mistakes.yaml')
    @mistakes = YAML.load(File.new(filename))
  end

end
