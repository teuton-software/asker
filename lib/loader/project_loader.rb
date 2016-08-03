# encoding: utf-8

require 'yaml'

require_relative '../project'

class ProjectLoader

  def self.load(pArgs={})
	  project=Project.instance

    if pArgs.class==Hash then
      project.param.merge!(pArgs)
    elsif pArgs.class==String then
      if not File.exist?(pArgs)
        project.verbose Rainbow("[WARN] Tool.init: ").yellow+Rainbow(pArgs).yellow.bright+Rainbow(" dosn't exists!").yellow
        exit 1
      end

      if pArgs.include?(".haml") then
        project.param[:inputdirs]      = File.dirname(pArgs)
        project.param[:process_file]   = File.basename(pArgs)
      elsif pArgs.include?(".yaml") then
        project.param=YAML::load(File.open(pArgs))
        project.param[:configfilename]=pArgs
        a=pArgs.split(File::SEPARATOR)
        a.delete_at(-1)
        project.param[:projectdir]=a.join(File::SEPARATOR)
      elsif File.directory?(pArgs) then
        project.verbose Rainbow("[WARN] Tool.init: Directory input ").yellow+Rainbow(pArgs).bright.yellow+Rainbow(" not implemented yet").yellow
        exit 1
        #app.param[:inputdirs]=pArgs
        #app.param[:process_file]=Dir.entries(pArgs)
      else
        project.verbose Rainbow("[ERR ] Tool.init: Input ").red+Rainbow(pArgs).red.bright+Rainbow(" unkown").red
        exit 1
      end
    else
      project.verbose Rainbow("[ERROR] Tool.init: Configuration params format is <#{pArgs.class.to_s}>!").red
      exit
    end
  end
end