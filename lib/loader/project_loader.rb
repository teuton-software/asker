
require 'yaml'
require_relative '../project'

class ProjectLoader

  def self.load(pArgs={})
    project=Project.instance

    if pArgs.class==Hash then
      project.param.merge!(pArgs)
    elsif pArgs.class==String then
      if not File.exist?(pArgs)
        project.verbose Rainbow("[WARN] ProjectLoader.load: ").yellow+Rainbow(pArgs).yellow.bright+Rainbow(" dosn't exists!").yellow
        exit 1
      end

      if File.extname(pArgs)==".haml" or  File.extname(pArgs)==".xml" then
        project.set( :inputdirs   ,  File.dirname(pArgs) )
        project.set( :process_file, File.basename(pArgs) )
      elsif File.extname(pArgs)==".yaml" then
        project.param.merge!( YAML::load(File.open(pArgs)) )
        project.set( :configfilename, pArgs )
        project.set( :projectdir    , File.dirname(pArgs) )
    elsif File.directory?(pArgs) then
        project.verbose Rainbow("[WARN] ProjectLoader.load: Directory input ").yellow+Rainbow(pArgs).bright.yellow+Rainbow(" not implemented yet").yellow
        exit 1
        #app.param[:inputdirs]=pArgs
        #app.param[:process_file]=Dir.entries(pArgs)
      else
        project.verbose Rainbow("[ERR ] ProjectLoader.load: Input ").red+Rainbow(pArgs).red.bright+Rainbow(" unkown").red
        exit 1
      end
    else
      project.verbose Rainbow("[ERROR] Tool.init: Configuration params format is <#{pArgs.class.to_s}>!").red
      exit
    end
  end
end
