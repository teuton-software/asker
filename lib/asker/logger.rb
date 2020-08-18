# frozen_string_literal: true

require 'singleton'
require_relative 'application'
require_relative 'project'

# Display and log project messages
class Logger
  include Singleton

  def initialize
    @logfile = null
  end

  ##
  # Display and log text
  def self.verbose(msg)
    puts msg if Application.instance.config['global']['verbose'] == 'yes'
    @logfile&.write("#{msg}\n")
  end

  ##
  # Display and log text line
  def self.verboseln(msg)
    verbose(msg + "\n")
  end

  ##
  # Create or reset logfile
  def self.create(project)
    @logfile = File.open(project.get(:logpath), 'w')
    @logfile.write('=' * 50 + "\n")
    @logfile.write("Created by : #{Application::NAME}")
    @logfile.write(" (version #{Application::VERSION})\n")
    @logfile.write("File       : #{project.get(:logname)}\n")
    @logfile.write("Time       : #{Time.new}\n")
    @logfile.write("Author     : David Vargas Ruiz\n")
    @logfile.write('=' * 50 + "\n\n")

    verbose '[INFO] Project open'
    verbose '   ├── inputdirs    = ' + Rainbow(project.get(:inputdirs)).bright
    verbose '   └── process_file = ' + Rainbow(project.get(:process_file)).bright
  end

  ##
  # Close Log file
  def self.close()
    @logfile.close
  end
end
