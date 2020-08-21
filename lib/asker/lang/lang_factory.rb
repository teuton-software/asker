# frozen_string_literal: true

require 'singleton'
require_relative 'lang'
require_relative '../application'

##
# LangFactory singleton class.
# * Read all language codes defined into configuration file
# * and load every language
# Lang objects are reused
class LangFactory
  include Singleton

  ##
  # Read all language codes from configuration file and load every language
  def initialize
    @default = Application.instance.config['languages']['default'].downcase
    @langs = {}
    Application.instance.config['languages'].each_pair do |key, value|
      code = key.downcase
      next if code == 'default'

      @langs[code] = Lang.new(code) if value.downcase == 'yes'
    end
  end

  ##
  # Return Lang object associated to code
  # @param code (String)
  def get(code)
    return @langs[code] unless @langs[code].nil?

    puts Rainbow("[ERROR] Unkown Lang code: #{code}").bright
    puts Rainbow('        => Change input file code lang').bright
    puts Rainbow('        => Revise configuration from config.ini').bright
    puts Rainbow('        => Revise template files').bright
    exit 1
  end

  ##
  # Return default Lang object
  def default
    get(@default)
  end
end
