# frozen_string_literal: true

require_relative 'application'
require_relative 'project'

# Display and log project messages
module Logger
  ##
  # Display and log text
  def self.verbose(msg)
    puts msg if Application.instance.config['global']['verbose'] == 'yes'
    Project.instance.get(:logfile)&.write("#{msg}\n")
  end

  ##
  # Display and log text line
  def self.verboseln(msg)
    verbose(msg + "\n")
  end
end
