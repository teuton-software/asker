# frozen_string_literal: true

require 'yaml'
require_relative '../project'
require_relative '../logger'

# Load params into Project class using arg input
# * load
# * load_from_string
# * load_from_yaml
# * load_from_directory
# * load_error
module ProjectLoader
  ##
  # Load project from args
  # @param args (String or Hash)
  def self.load(args)
    project = Project.instance

    if args.class == Hash
      project.param.merge!(args)
      return project
    elsif args.class == String
      ProjectLoader.load_from_string(args)
      return project
    end

    msg = '[ERROR] ProjectLoader:'
    msg += "Configuration params format is <#{pArgs.class}>!"
    Logger.verbose Rainbow(msg).red
    raise msg
  end

  ##
  # Load project from filepath. Options:
  # * HAML filepath
  # * XML filepath
  # * YAML filepath
  # @param filepath (String)
  def self.load_from_string(filepath)
    project = Project.instance
    unless File.exist?(filepath)
      msg = Rainbow("[ERROR] #{filepath} not found!").red.bright
      Logger.verbose msg
      exit 1
    end

    if File.extname(filepath) == '.haml' || File.extname(filepath) == '.xml'
      project.set(:inputdirs, File.dirname(filepath))
      project.set(:process_file, File.basename(filepath))
      return project
    elsif File.extname(filepath) == '.yaml'
      return load_from_yaml(filepath)
    else
      error_loading(filepath)
    end
  end

  def self.load_from_yaml(arg)
    project = Project.instance
    project.param.merge!(YAML.load(File.open(arg)))
    project.set(:configfilename, arg)
    project.set(:projectdir, File.dirname(arg))
    project
  end

  ##
  # Error found and exit application.
  def self.error_loading(arg)
    msg = Rainbow("[ERROR] Loading... #{arg}").red.bright
    Logger.verbose msg
    exit 1
  end
end
