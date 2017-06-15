
require 'yaml'
require_relative '../project'

# Load params into Project class using arg input
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

    msg = '[ERR ] ProjectLoader:'
    msg += "Configuration params format is <#{pArgs.class}>!"
    project.verbose Rainbow(msg).red
    exit 1
  end

  def self.load_from_string(arg)
    project = Project.instance
    unless File.exist?(arg)
      msg = Rainbow('[WARN] ProjectLoader.load: ').yellow
      msg += Rainbow(arg).yellow.bright + Rainbow(" dosn't exists!").yellow
      project.verbose msg
      exit 1
    end

    if File.extname(arg) == '.haml' || File.extname(arg) == '.xml'
      project.set(:inputdirs, File.dirname(arg))
      project.set(:process_file, File.basename(arg))
    elsif File.extname(arg) == '.yaml'
      project.param.merge!(YAML.load(File.open(arg)))
      project.set(:configfilename, arg)
      project.set(:projectdir, File.dirname(arg))
    elsif File.directory?(arg)
      msg = Rainbow('[WARN] ProjectLoader.load: Directory input ').yellow
      msg += Rainbow(arg).bright.yellow
      msg += Rainbow(' not implemented yet').yellow
      project.verbose msg
      exit 1
    else
      msg = Rainbow('[ERR ] ProjectLoader: Input ').red
      msg += Rainbow(arg).red.bright + Rainbow(' unkown').red
      project.verbose msg
      exit 1
    end
  end
end
