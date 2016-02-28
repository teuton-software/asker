#!/usr/bin/ruby
# encoding: utf-8
#

require 'singleton'
require 'yaml'
require 'haml'
require 'rainbow'
require 'rexml/document'

require_relative 'concept'
require_relative 'tool/create_actions'
require_relative 'tool/log_actions'
require_relative 'tool/input_actions'
require_relative 'tool/show_actions'

=begin
The main method of this class is "run", this does
1) Inicialize configuration parameter values.
2) Read HAML/XML files from the directories indicated by "inputdirs" values.
3) Process the contents and definitions from this HAML/XML files.
4) Create GIFT questions from this contens and save output files into output directory
=end

class Tool
  include Singleton
  include CreateActions
  include InputActions
  include LogActions
  include ShowActions
    	
  def run(pArgs={})
    init pArgs
    create_log_file
    load_input_files
    show_data if Application.instance.show_mode!=:none
	create_output_files
	show_stats
	close_log_file
  end
	
  def init(pArgs={})
	app=Application.instance
	
    if pArgs.class==Hash then
      app.param=pArgs
    elsif pArgs.class==String then
      begin
        if File.exist?(pArgs) then
          app.param=YAML::load(File.open(pArgs))
          app.param[:configfilename]=pArgs
          a=pArgs.split("/")
          a.delete_at(-1)
          app.param[:projectdir]=a.join("/")
        elsif File.directory?(pArgs) then
          app.param[:inputdirs]=pArgs
          app.param[:process_file]=Dir.entries(pArgs)                 
        else
          raise
        end
      rescue
        verbose Rainbow("[ERROR] <#{RainbowpArgs}> dosn't exists! (tool#init)").color(:red)
        exit    
      end
    else
      verbose Rainbow("[ERROR] Configuration params format is <#{pArgs.class.to_s}>! (tool#init)").color(:red)
      exit
    end

    app.fill_param_with_default_values

    @concepts={}
		
    @logname=app.outputdir+'/'+app.logname
    @outputname=app.outputdir+'/'+app.outputname
  end
		
  def verbose(lsText)
    if Application.instance.verbose then
      puts lsText
      @logfile.write(lsText.to_s+"\n") if @logfile
    end
  end
  
end	
