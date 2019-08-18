# frozen_string_literal: true

require 'singleton'
require 'inifile'

# Global parameters
class Application
  include Singleton

  attr_reader :config

  def initialize
    filename = File.join(File.dirname(__FILE__), '..', 'config.ini')
    @config = IniFile.load(filename)
  end

  def name
    'asker'
  end

  def version
    '2.0.0'
  end
end
