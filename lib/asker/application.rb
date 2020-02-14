# frozen_string_literal: true

require 'singleton'
require 'inifile'

# Global parameters
class Application
  include Singleton

  VERSION = '2.1.1'  # Application version
  NAME = 'asker'     # Application name

  attr_reader :config

  # Initialize Application singleton
  def initialize
    reset
  end

  def reset
    filename = File.join(File.dirname(__FILE__), '..', '..', 'config.ini')
    @config = IniFile.load(filename)
  end
end
