# frozen_string_literal: true

require 'singleton'
require_relative 'version'

# Display and log project messages
class Logger
  include Singleton
  @attr_verbose = 'yes'

  def set_verbose(value)
    @attr_verbose = value
  end

  def self.verbose(msg)
    print msg if @attr_verbose == 'yes'
    @logfile&.write(msg)
  end

  def self.verboseln(msg)
    verbose(msg + "\n")
  end

  def log(msg)
    verbose(msg)
  end

  def logln(msg)
    verboseln(msg)
  end
  ##
  # Create or reset logfile
  def self.create(logpath, logname)
    @logfile = File.open(logpath, 'w')
    @logfile.write('=' * 50 + "\n")
    @logfile.write("Created by : #{Version::NAME}")
    @logfile.write(" (version #{Version::VERSION})\n")
    @logfile.write("File       : #{logname}\n")
    @logfile.write("Time       : #{Time.new}\n")
    @logfile.write("Author     : David Vargas Ruiz\n")
    @logfile.write('=' * 50 + "\n\n")
  end

  def self.close
    @logfile.close
  end
end
