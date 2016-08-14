
require 'singleton'
require_relative 'lang'
require_relative '../project'

class LangFactory
  include Singleton

  def initialize
    @langs   = {}
    Project.instance.locales.each { |locale| @langs[locale]=Lang.new(locale) }
  end

  def get(locale)
    return @langs[locale]
  end
end
