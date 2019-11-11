# frozen_string_literal: true

require 'rainbow'
require_relative '../application'

# Command Line User Interface
class Asker < Thor
  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'show the program version'
  def version
    app = Application.instance
    print Rainbow(app.name).bright.blue
    puts  ' (version ' + Rainbow(app.version).green + ')'
  end
end
