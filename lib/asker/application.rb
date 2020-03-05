# frozen_string_literal: true

require 'singleton'
require 'inifile'
require 'rainbow'

# Global parameters
class Application
  include Singleton

  VERSION = '2.1.6'    # Application version
  NAME = 'asker'       # Application name
  GEM = 'asker-tool' # Gem name
  attr_reader :config

  ##
  # Initialize Application singleton
  def initialize
    reset
  end

  ##
  # Initialize config values from external "config.ini" file.
  def reset
    filename = File.join(Dir.pwd, 'config.ini')
    unless File.exist? filename
      filename = File.join(File.dirname(__FILE__), 'files', 'config.ini')
    end
    begin
      @config = IniFile.load(filename)
    rescue StandardError => e
      puts Rainbow("[ERROR] Revise config.ini syntax!").red.bright
      puts e.display
      exit 1
    end
  end
end
