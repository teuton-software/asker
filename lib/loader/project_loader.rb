
require 'yaml'
require_relative '../project'

# Load params into Project class using arg input
module ProjectLoader
  def self.load(pArgs = {})
    project = Project.instance

    if pArgs.class == Hash
      project.param.merge!(pArgs)
      return true
    end

    if pArgs.class != String
      msg = '[ERR ] ProjectLoader:'
      msg += "Configuration params format is <#{pArgs.class}>!"
      project.verbose Rainbow(msg).red
      exit
    end

    unless File.exist?(pArgs)
      msg = Rainbow('[WARN] ProjectLoader.load: ').yellow
      msg += Rainbow(pArgs).yellow.bright + Rainbow(" dosn't exists!").yellow
      project.verbose msg
      exit 1
    end

    if File.extname(pArgs) == '.haml' || File.extname(pArgs) == '.xml'
      project.set(:inputdirs, File.dirname(pArgs))
      project.set(:process_file, File.basename(pArgs))
    elsif File.extname(pArgs) == '.yaml'
      project.param.merge!(YAML.load(File.open(pArgs)))
      project.set(:configfilename, pArgs)
      project.set(:projectdir, File.dirname(pArgs))
    elsif File.directory?(pArgs)
      msg = Rainbow('[WARN] ProjectLoader.load: Directory input ').yellow
      msg += Rainbow(pArgs).bright.yellow
      msg += Rainbow(' not implemented yet').yellow
      project.verbose msg
      exit 1
    else
      msg = Rainbow('[ERR ] ProjectLoader: Input ').red
      msg += Rainbow(pArgs).red.bright + Rainbow(' unkown').red
      project.verbose msg
      exit 1
    end
  end
end
