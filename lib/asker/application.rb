# frozen_string_literal: true

require 'singleton'
require 'inifile'

# Global parameters
class Application
  include Singleton

  VERSION = '2.1.0'
  NAME = 'asker'
  
  attr_reader :config, :name, :version

  def initialize
    reset
  end

  def reset
    filename = File.join(File.dirname(__FILE__), '..', '..', 'config.ini')
    @config = IniFile.load(filename)
    @name = 'asker'
    @version = '2.1.0'
  end
end
