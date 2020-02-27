# frozen_string_literal: true

require 'yaml'
require_relative '../project'

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
      return true
    elsif args.class == String
      ProjectLoader.load_from_string(args)
      return true
    end

    msg = '[ERROR] ProjectLoader:'
    msg += "Configuration params format is <#{pArgs.class}>!"
    project.verbose Rainbow(msg).red
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
      msg = Rainbow("[WARN] ProjectLoader.load: #{arg} dosn't exists!").yellow.bright
      project.verbose msg
      raise msg
    end

    if File.extname(filepath) == '.haml' || File.extname(filepath) == '.xml'
      project.set(:inputdirs, File.dirname(filepath))
      project.set(:process_file, File.basename(filepath))
    elsif File.extname(filepath) == '.yaml'
      load_from_yaml(filepath)
    elsif File.directory?(filepath)
      load_from_directory(filepath)
    else
      load_error(filepath)
    end
  end

  def self.load_from_yaml(arg)
    project = Project.instance
    project.param.merge!(YAML.load(File.open(arg)))
    project.set(:configfilename, arg)
    project.set(:projectdir, File.dirname(arg))
  end

  def self.load_from_directory(dirpath)
    msg = Rainbow('[WARN] ProjectLoader.load: Directory input ').yellow
    msg += Rainbow(dirpath).bright.yellow
    msg += Rainbow(' not implemented!').yellow
    Project.instance.verbose msg
    exit 1
  end

  def self.load_error(arg)
    msg = Rainbow('[ERR ] ProjectLoader: Input ').red
    msg += Rainbow(arg).red.bright + Rainbow(' unkown').red
    Project.instance.verbose msg
    raise msg
  end
end
