#!/usr/bin/ruby
# encoding: utf-8
#

require 'singleton'
require 'yaml'
require 'haml'
require 'rainbow'
require 'rexml/document'
require 'terminal-table'
require_relative 'concept'
require_relative 'lang'
require_relative 'tool/create_actions'
require_relative 'tool/show_actions'

=begin
The main method of this class is "run"

Interviewer.run do the next actions:
1) Inicialize configuration parameter values.
2) Read HAML/XML files from the directories indicated by "inputdirs" values.
3) Process the contents and definitions from this HAML/XML files.
4) Create GIFT questions from this contens and save output files into output directory

=end

class Tool
  include Singleton
  include CreateActions
  include ShowActions
    
  attr_reader :lang
	
  def run(pArgs={})
    init pArgs
    create_log_file
    load_input_files
    show_data if Application.instance.param[:show_mode]!=:none
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
        puts "[ERROR] <#{pArgs}> dosn't exists!"
        exit    
      end
    else
      puts "[ERROR] Configuration params format is <#{pArgs.class.to_s}>!"
      exit
    end

    app.fill_param_with_default_values

    @concepts={}
		
    @logname=app.outputdir+'/'+app.logname
    @outputname=app.outputdir+'/'+app.outputname
  end

  def load_input_files
	app=Application.instance
    verbose "\n[INFO] Loading input data..."
		
    inputdirs=app.inputdirs.split(',')
    inputdirs.each do |dirname|
      if !Dir.exists? dirname then
        raise "[ERROR] <#{dirname}> directory dosn't exist!"
      end
      files=(Dir.new(dirname).entries-[".",".."]).sort
      filter = files.select { |f| f[-4..-1]==".xml" || f[-5..-1]==".haml" } # filter only HAML or XML files
      verbose "* HAML/XML files from #{dirname}: #{filter.join(', ').to_s} "
		
      filter.each do |f|
        pFilename=dirname+'/'+f
        if pFilename[-5..-1]==".haml" then
          template = File.read(pFilename)
          haml_engine = Haml::Engine.new(template)
          lFileContent = haml_engine.render
        else
          lFileContent=open(pFilename) { |i| i.read }				
        end
				
        begin
          lXMLdata=REXML::Document.new(lFileContent)
          app.param[:lang]=lXMLdata.root.attributes['lang'] || app.lang
          @lang=Lang.new(app.lang)
					
          lXMLdata.root.elements.each do |i|
            if i.name=='concept' then
              c=Concept.new(i)
              #c.lang=@param[:lang]
              c.process=false
              if ( app.process_file==:default or app.process_file==f.to_s ) then
                c.process=true
              end
              @concepts[c.name]=c
            end
          end
        rescue REXML::ParseException
          verbose "[ERROR] Format error in file <"+pFilename+">!"
          raise "[ERROR] Format error in file <"+pFilename+">!"
        end
      end
    end
		
    #find neighbors for every concept
    @concepts.each_value do |i|
      @concepts.each_value do |j|
        if (i.id!=j.id) then
          i.try_adding_neighbor j
        end
      end
    end
  end	
		
  def close_log_file
    @logfile.close
  end
		
private	

  def verbose(lsText)
    if Application.instance.verbose then
      puts lsText
      @logfile.write(lsText.to_s+"\n") if @logfile
    end
  end
  
end	
