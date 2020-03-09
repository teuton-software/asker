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
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def reset
    filename = File.join(Dir.pwd, 'config.ini')
    unless File.exist? filename
      filename = File.join(File.dirname(__FILE__), 'files', 'config.ini')
    end
    begin
      @config = IniFile.load(filename)
    rescue StandardError => e
      puts e.display
      puts Rainbow('[ERROR] Revise configuration file:').red.bright
      puts Rainbow("        #{filename}").red.bright
      exit 1
    end
    stages = @config['questions']['stages'].split(',')
    @config['questions']['stages'] = stages.map(&:to_sym)
    Rainbow.enabled = false
    Rainbow.enabled = true if @config['global']['color'].downcase == 'yes'
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
