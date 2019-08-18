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
  def self.load(args = {})
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

  def self.load_from_string(arg)
    project = Project.instance
    unless File.exist?(arg)
      msg = Rainbow('[WARN] ProjectLoader.load: ').yellow
      msg += Rainbow(arg).yellow.bright + Rainbow(" dosn't exists!").yellow
      project.verbose msg
      raise msg
    end

    if File.extname(arg) == '.haml' || File.extname(arg) == '.xml'
      project.set(:inputdirs, File.dirname(arg))
      project.set(:process_file, File.basename(arg))
    elsif File.extname(arg) == '.yaml'
      load_from_yaml(arg)
    elsif File.directory?(arg)
      load_from_directory(arg)
    else
      load_error(arg)
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
