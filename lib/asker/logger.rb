require "singleton"
require_relative "version"

class Logger
  include Singleton

  def initialize
    @verbose = true
  end

  def iset_verbose(value)
    @verbose = (value == "yes")
  end

  def idebug(msg)
    msg = Rainbow("#{msg}").white
    puts msg if @verbose
    @logfile&.write(msg)
  end

  def iinfo(msg)
    puts msg if @verbose
    @logfile&.write(msg)
  end

  def iwarn(msg)
    msg = Rainbow("[WARN] #{msg}\n").yellow.bright
    puts msg if @verbose
    @logfile&.write(msg)
  end

  def ierror(msg)
    msg = Rainbow("[ERROR] #{msg}\n").red.bright
    Warning.warn msg if @verbose
    @logfile&.write(msg)
  end

  def iverbose(msg)
    print msg if @verbose
    @logfile&.write(msg)
  end

  def iverboseln(msg)
    iverbose(msg + "\n")
  end

  def icreate(logpath)
    @logfile = File.open(logpath, "w")
    @logfile.write("=" * 50 + "\n")
    @logfile.write("Created by : #{Asker::NAME}")
    @logfile.write(" (version #{Asker::VERSION})\n")
    @logfile.write("File       : #{File.basename(logpath)}\n")
    @logfile.write("Time       : #{Time.new}\n")
    @logfile.write("=" * 50 + "\n\n")
  end

  def iclose
    @logfile.close
  end

  def self.set_verbose(value)
    Logger.instance.iset_verbose(value)
  end

  def self.debug(msg)
    Logger.instance.idebug(msg)
  end

  def self.info(msg)
    Logger.instance.iinfo(msg)
  end

  def self.warn(msg)
    Logger.instance.iwarn(msg)
  end

  def self.error(msg)
    Logger.instance.ierror(msg)
  end

  def self.verbose(msg)
    Logger.instance.iverbose(msg)
  end

  def self.verboseln(msg)
    Logger.instance.iverboseln(msg)
  end

  def self.create(msg)
    Logger.instance.icreate(msg)
  end

  def self.close
    Logger.instance.iclose
  end
end
