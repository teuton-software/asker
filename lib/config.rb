# frozen_string_literal: true

require 'singleton'
require 'inifile'

# Config class
class Config
  include Singleton

  def initialize
    @sections = IniFile.load('config.ini')
  end

  def [](key)
    @sections[key]
  end
end
