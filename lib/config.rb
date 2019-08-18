# frozen_string_literal: true

require 'inifile'

# Config class
class Config
  def initialize(filename)
    @sections = IniFile.load(filename)
  end

  def [](key)
    @sections[key]
  end

  def to_s
    @sections.to_s
  end
end
