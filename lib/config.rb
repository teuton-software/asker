require 'singleton'
require 'inifile'

class Config
  include Singleton

  def initialize
    @sections = IniFile.load('config.ini')
  end

  def [](key)
    @sections[key]
  end
end
