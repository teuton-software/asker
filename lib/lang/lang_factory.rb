
require 'singleton'
require_relative 'lang'
require_relative '../project'

class LangFactory
  include Singleton

  def initialize
    locales  = [ 'en', 'es', 'maths' ]
    @langs   = {}
    locales.each { |locale| @langs[locale]=Lang.new(locale) }
  end

  def get(locale)
    return @langs[locale]
  end
end
