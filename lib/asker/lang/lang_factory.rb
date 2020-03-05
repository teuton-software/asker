# frozen_string_literal: true

require 'singleton'
require_relative 'lang'
require_relative '../application'

# LangFactory#get
class LangFactory
  include Singleton

  def initialize
    @langs = {}
    languages = Application.instance.config['languages'].dup
    languages.delete("default")
    languages.each_pair do |key, value|
      next if key == 'default'
      @langs[key] = Lang.new(key) if value.downcase == 'yes'
    end
#    Project.instance.locales.each { |i| @langs[i] = Lang.new(i) }
  end

  def get(locale)
    @langs[locale]
  end
end
