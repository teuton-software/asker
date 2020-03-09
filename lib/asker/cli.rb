# frozen_string_literal: true

require 'rainbow'
require 'thor'
require_relative 'application'
require_relative '../asker'

##
# Command Line User Interface
class CLI < Thor
  map ['h', '-h', '--help'] => 'help'

  map ['v', '-v', '--version'] => 'version'
  desc 'version', 'Show the program version'
  ##
  # Show current version
  def version
    print Rainbow(Application::NAME).bright.blue
    puts  " (version #{Rainbow(Application::VERSION).green})"
  end

  map ['f', '-f', '--file'] => 'file'
  desc 'file NAME', 'Build output files, from HAML/XML input file.'
  long_desc <<-LONGDESC
  Create output files, from input file (HAML/XML format).

  Build questions about contents defined into input file specified.

  Examples:

  (1) #{Rainbow('asker input/foo/foo.haml').yellow}, Build questions from HAML file.

  (2) #{Rainbow('asker input/foo/foo.xml').yellow}, Build questions from XML file.

  (3) #{Rainbow('asker projects/foo/foo.yaml').yellow}, Build questions from YAML project file.

  LONGDESC
  ##
  # Create questions from input file
  # @param filename (String) Path to input file
  def file(filename)
    # Asker start processing input file
    Asker.start(filename)
  end

  map ['c', '-c', '--check'] => 'check'
  desc 'check', 'Check input HAML file syntax'
  ##
  # Check input file syntax
  # @param filename (String) Path to input file
  def check(filename)
    # Enable/disable color output
    Rainbow.enabled = false if options['color'] == false
    # Asker start processing input file
    Asker.check(filename)
  end

  map ['i', '-i', '--init'] => 'init'
  desc 'init', 'Create default INI config fie'
  ##
  # Create default INI config file
  def init
    Asker.create_configuration
  end

  map ['n', '-b', '--new', 'new'] => 'create_input'
  desc 'new', 'Create Asker demo input files'
  ##
  # Create Asker demo input files
  # @param dirname (String) Path to folder
  def create_input(dirname)
    Asker.create_input(dirname)
  end

  ##
  # This actions are equals:
  # * asker demo/foo.haml
  # * asker file demo/fool.haml
  def method_missing(method, *_args, &_block)
    file(method.to_s)
  end
end
