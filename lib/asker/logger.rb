require_relative "version"

class Logger
  @verbose = true

  def self.set_verbose(value)
    @verbose = (value == "yes")
  end

  def self.debug(msg)
    msg = Rainbow("#{msg}").white
    puts msg if @verbose
    @logfile&.write(msg)
  end

  def self.info(msg)
    puts msg if @verbose
    @logfile&.write(msg)
  end

  def self.warn(msg)
    msg = Rainbow("[WARN] #{msg}\n").yellow.bright
    puts msg if @verbose
    @logfile&.write(msg)
  end

  def self.error(msg)
    msg = Rainbow("[ERROR] #{msg}\n").red.bright
    Warning.warn msg if @verbose
    @logfile&.write(msg)
  end

  def self.verbose(msg)
    print msg if @verbose
    @logfile&.write(msg)
  end

  def self.verboseln(msg)
    verbose(msg + "\n")
  end

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
