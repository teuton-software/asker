
require 'yaml'
require_relative '../project'

class ProjectLoader
  def self.load(pArgs = {})
    project = Project.instance

    if pArgs.class == Hash
      project.param.merge!(pArgs)
    elsif pArgs.class == String
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
        project.param.merge!(YAML::load(File.open(pArgs)))
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
        msg += Rainbow(pArgs).red.bright + Rainbow(" unkown").red
        project.verbose msg
        exit 1
      end
    else
      msg = Rainbow(format("[ERR ] ProjectLoader: Configuration params format is <%s!>", pArgs.class)).red
      project.verbose msg
      exit
    end
  end
end
