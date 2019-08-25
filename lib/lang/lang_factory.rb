# frozen_string_literal: true

require 'singleton'
require_relative 'lang'
require_relative '../project'

# LangFactory#get
class LangFactory
  include Singleton

  def initialize
    @langs = {}
    Project.instance.locales.each { |i| @langs[i] = Lang.new(i) }
  end

  def get(locale)
    @langs[locale]
  end
end
