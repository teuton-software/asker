# frozen_string_literal: true

require 'singleton'
require 'inifile'

# Global parameters
class Application
  include Singleton

  VERSION = '2.1.1'  # Application version
  NAME = 'asker'     # Application name

  attr_reader :config

  ##
  # Initialize Application singleton
  def initialize
    reset
  end

  ##
  # Initialize config values from external "config.ini" file.
  def reset
    filename = File.join(Dir.pwd,'config.ini')
    unless File.exist? filename
      filename = File.join(File.dirname(__FILE__), 'files','config.ini')
    end
    @config = IniFile.load(filename)
  end
end
