# frozen_string_literal: true

require "rainbow"
require "thor"
require_relative "version"
require_relative "../asker"

##
# Command Line User Interface
class CLI < Thor
  map ["-h", "--help"] => "help"

  map ["-v", "--version"] => "version"
  desc "version", "Show the program version"
  def version
    puts "#{Asker::NAME} version #{Asker::VERSION}"
    exit 0
  end

  map ["--init"] => "init"
  desc "init", "Create default INI config file"
  def init
    Asker.init
    exit 0
  end

  map ["new", "--new"] => "create_input"
  desc "new PATH", "Create Asker sample input file"
  long_desc <<-LONGDESC

  Create Asker sample input file (HAML format).

  Examples:

  (1) #{Rainbow("asker new foo/bar.haml").aqua}, Create "foo" dir and "bar.haml" file.
  Path to input file can be relative or absolute.

  (2) #{Rainbow("asker new foo").aqua}, Create "foo" dir and sample HAML file.
  Path to directory can be relative or absolute.

  LONGDESC
  def create_input(dirname)
    Asker.create_input(dirname)
    exit 0
  end

  map ["--check"] => "check"
  option :color, type: :boolean
  desc "check FILEPATH", "Check HAML input file syntax"
  long_desc <<-LONGDESC

  Check HAML input file syntax.

  Examples:

  (*) #{Rainbow("asker check foo/bar.haml").aqua}, Check "bar.haml" input file.
  Path to input file can be relative or absolute.

  LONGDESC
  def check(filename)
    # Enable/disable color output
    Rainbow.enabled = false if options["color"] == false
    # Asker start processing input file
    Asker.check(filename)
  end

  map ["f", "-f", "--file"] => "file"
  option :color, type: :boolean
  desc "[file] FILEPATH", "Build output files, from HAML/XML input file."
  long_desc <<-LONGDESC

  Build questions about contents defined into input file specified.

  Create output files, from input file (HAML/XML format).

  Examples:

  (1) #{Rainbow("asker foo/bar.haml").aqua}, Build questions from HAML input file.
  Path to input file can be relative or absolute.

  (2) #{Rainbow("asker foo/bar.xml").aqua}, Build questions from XML input file.
  Path to input file can be relative or absolute.

  LONGDESC
  def file(filename)
    Asker.start(filename)
  end

  ##
  # This actions are equals:
  # * asker demo/foo.haml
  # * asker file demo/fool.haml
  def method_missing(method, *_args, &_block)
    file(method.to_s)
  end

  def respond_to_missing?(_method_name)
    true
  end

  ##
  # Thor stop and show messages on screen on failure
  def self.exit_on_failure?
    true
  end
end
