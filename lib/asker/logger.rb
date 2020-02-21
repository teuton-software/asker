# frozen_string_literal: true

require_relative 'project'

# Display and log project messages
module Logger
  ##
  # Display and log text
  def self.verbose(msg)
    project = Project.instance
    puts msg if project.get(:verbose)
    project.get(:logfile).write("#{msg}\n") if project.get(:logfile)
    # project.get(:logfile)&.project.get(:logfile).write("#{msg}\n")
  end

  ##
  # Display and log text line
  def self.verboseln(msg)
    verbose(msg + "\n")
  end
end
