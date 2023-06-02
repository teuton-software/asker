require "singleton"
require_relative "version"

class Logger
  include Singleton
  @attr_verbose = "yes"

  def set_verbose(value)
    @attr_verbose = value
  end

  def self.info(msg)
    puts msg if @attr_verbose == "yes"
    @logfile&.write(msg)
  end

  def self.warn(msg)
    msg = Rainbow(msg).yellow.bright
    puts msg if @attr_verbose == "yes"
    @logfile&.write(msg)
  end

  def self.error(msg)
    msg = Rainbow(msg).red
    puts msg if @attr_verbose == "yes"
    @logfile&.write(msg)
  end

  def self.verbose(msg)
    print msg if @attr_verbose == "yes"
    @logfile&.write(msg)
  end

  def self.verboseln(msg)
    verbose(msg + "\n")
  end

  #def log(msg)
  #  verbose(msg)
  #end

  #def logln(msg)
  #  verboseln(msg)
  #end

  def self.create(logpath)
    @logfile = File.open(logpath, "w")
    @logfile.write("=" * 50 + "\n")
    @logfile.write("Created by : #{Asker::NAME}")
    @logfile.write(" (version #{Asker::VERSION})\n")
    @logfile.write("File       : #{File.basename(logpath)}\n")
    @logfile.write("Time       : #{Time.new}\n")
    @logfile.write("=" * 50 + "\n\n")
  end

  def self.close
    @logfile.close
  end
end
