# frozen_string_literal: true

require 'erb'
require 'yaml'
require_relative 'text_actions'
require_relative '../logger'

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
    dirbase = File.join(File.dirname(__FILE__), '..', 'files', 'locales')
    filepath = File.join(dirbase, @code, 'templates.yaml')
    @templates = load_yaml_file(filepath)
    filepath = File.join(dirbase, @code, 'connectors.yaml')
    @connectors = load_yaml_file(filepath)
    filepath = File.join(dirbase, @code, 'mistakes.yaml')
    @mistakes = load_yaml_file(filepath)
  end

  def load_yaml_file(filepath)
    begin
      content = YAML.load(File.new(filepath))
    rescue StandardError => e
      Logger.verboseln "[ERROR] lang.initialize(): Reading YAML file <#{filepath}>"
      Logger.verboseln "[ADVISE] Revise apostrophe into string without \\ char\n"
      raise e
    end
    content
  end
end
