# frozen_string_literal: true

require 'singleton'
require 'inifile'
require 'rainbow'
require_relative 'version'

# Global parameters
class Application
  include Singleton
  attr_reader :config

  def initialize
    reset
  end

  def reset
    filename = File.join(Dir.pwd,
                         Version::CONFIGFILE)
    filename = File.join(File.dirname(__FILE__),
                         'files',
                          Version::CONFIGFILE) unless File.exist? filename

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
end
