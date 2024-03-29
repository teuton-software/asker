require "singleton"
require "inifile"
require "rainbow"
require_relative "logger"
require_relative "version"

# Global parameters
class Application
  include Singleton
  attr_reader :config

  def initialize
    reset
  end

  def reset
    filename = File.join(Dir.pwd,
      Asker::CONFIGFILE)
    unless File.exist? filename
      filename = File.join(File.dirname(__FILE__),
        "files",
        Asker::CONFIGFILE)
    end

    begin
      @config = IniFile.load(filename)
    rescue => e
      Logger.error e.display
      Logger.error "Application: Revise configuration file (#{filename})"
      exit 1
    end
    stages = @config["questions"]["stages"].split(",")
    @config["questions"]["stages"] = stages.map(&:to_sym)

    fractions = @config["questions"]["fractions"].split(",")
    @config["questions"]["fractions"] = fractions + Array.new(5, "0")

    Rainbow.enabled = false
    Rainbow.enabled = true if @config["global"]["color"].downcase == "yes"
  end
end
