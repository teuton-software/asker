# frozen_string_literal: true

require 'singleton'
require_relative 'application'

# Display and log project messages
class Logger
  include Singleton

  def initialize
    @logfile = null
  end

  ##
  # Display and log text
  def self.verbose(msg)
    print msg if Application.instance.config['global']['verbose'] == 'yes'
    @logfile&.write(msg)
  end

  ##
  # Display and log text line
  def self.verboseln(msg)
    verbose(msg + "\n")
  end

  ##
  # Create or reset logfile
  def self.create(logpath, logname)
    @logfile = File.open(logpath, 'w')
    @logfile.write('=' * 50 + "\n")
    @logfile.write("Created by : #{Application::NAME}")
    @logfile.write(" (version #{Application::VERSION})\n")
    @logfile.write("File       : #{logname}\n")
    @logfile.write("Time       : #{Time.new}\n")
    @logfile.write("Author     : David Vargas Ruiz\n")
    @logfile.write('=' * 50 + "\n\n")
  end

  ##
  # Close Log file
  def self.close
    @logfile.close
  end
end
