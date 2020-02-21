# frozen_string_literal: true

require 'singleton'
require_relative 'project'

# Display and log project messages
class Logger
  include Singleton

  ##
  # Display and log text
  def verbose(msg)
    project = Project.instance
    puts msg if project.get(:verbose)
    project.get(:logfile).write("#{msg}\n") if project.get(:logfile)
    # project.get(:logfile)&.project.get(:logfile).write("#{msg}\n")
  end

  ##
  # Display and log text line
  def verboseln(msg)
    verbose(msg + "\n")
  end
end
