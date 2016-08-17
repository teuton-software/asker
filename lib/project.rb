# encoding: utf-8

require 'singleton'
require_relative 'application'

class Project
  include Singleton
  attr_reader   :default
  attr_accessor :param

  def initialize
    @default = {}
    @default[:inputbasedir]    = "input"
    @default[:outputdir]       = "output"
    @default[:category]        = :none
    @default[:formula_weights] = [1,1,1]
    @default[:lang]            = 'en'
    @default[:locales]         = [ 'en', 'es', 'maths' ]
    @default[:show_mode]       = :default
    @default[:verbose]         = true
    @default[:stages]          = [ :stage_d, :stage_b, :stage_c, :stage_f, :stage_i, :stage_s ]

    @param   = {}
  end

  def method_missing(m, *args, &block)
    get(m)
  end

  def get(key)
    return @param[key] unless @param[key].nil?
    return @default[key]
  end

  def set(key,value)
    @param[key]=value
  end

  def open
    #We need at least process_file and inputdirs params
    ext = ".haml"
    @param[:process_file] = @param[:process_file] || get(:projectdir).split(File::SEPARATOR).last + ext
    @param[:projectname]  = @param[:projectname]  || File.basename( @param[:process_file], ext)
    @param[:inputdirs]    = @param[:inputdirs]    || File.join( get(:inputbasedir), @param[:projectdir] )

    @param[:logname]      = @param[:logname]      || "#{@param[:projectname]}-log.txt"
    @param[:outputname]   = @param[:outputname]   || "#{@param[:projectname]}-gift.txt"
    @param[:lessonname]   = @param[:lessonname]   || "#{@param[:projectname]}-doc.txt"

    @param[:logpath]      = @param[:logpath]      || File.join( get(:outputdir), @param[:logname] )
    @param[:outputpath]   = @param[:outputpath]   || File.join( get(:outputdir), @param[:outputname] )
    @param[:lessonpath]   = @param[:lessonpath]   || File.join( get(:outputdir), @param[:lessonname] )

    create_log_file
    create_output_file
    create_lesson_file
  end

  def close
    get(:logfile).close
    get(:outputfile).close
    get(:lessonfile).close
  end

  def verbose(lsText)
    puts lsText if get(:verbose)
    get(:logfile).write(lsText.to_s+"\n") if get(:logfile)
  end

  def verboseln(lsText)
    verbose(lsText+"\n")
  end

private
  def create_log_file
    #create or reset logfile
    Dir.mkdir( get(:outputdir) ) if !Dir.exists?( get(:outputdir) )

    @param[:logfile] = File.open( get(:logpath),'w')
    f = get(:logfile)
    f.write("="*50+"\n")
    f.write("Created by : #{Application::name} (version #{Application::version})\n")
    f.write("File       : #{get(:logname)}\n")
    f.write("Time       : "+Time.new.to_s+"\n")
    f.write("Author     : David Vargas\n")
    f.write("="*50+"\n\n")

    verbose "[INFO] Project open"
    verbose "   ├── inputdirs    = " + Rainbow( get(:inputdirs).to_s ).bright
    verbose "   └── process_file = " + Rainbow( get(:process_file) ).bright
  end

  def create_output_file
    #Create or reset output file
    Dir.mkdir( get(:outputdir) ) if !Dir.exists? get(:outputdir)

    @param[:outputfile] = File.open( get(:outputpath),'w')
    f = get(:outputfile)
    f.write("// "+("="*50)+"\n")
    f.write("// Created by : #{Application::name} (version #{Application::version})\n")
    f.write("// File       : #{ get(:outputname) }\n")
    f.write("// Time       : "+Time.new.to_s+"\n")
    f.write("// Author     : David Vargas\n")
    f.write("// "+("="*50)+"\n")
    f.write("\n")
    f.write("$CATEGORY: $course$/#{ get(:category).to_s}\n") if get(:category)!=:none
  end

  def create_lesson_file
    #Create or reset lesson file
    @param[:lessonfile] = File.new( get(:lessonpath),'w')
    f = get(:lessonfile)
    f.write("="*50+"\n")
    f.write("Created by : #{Application::name} (version #{Application::version})\n")
    f.write("File       : #{ get(:lessonname) }\n")
    f.write("Time       : "+Time.new.to_s+"\n")
    f.write("Author     : David Vargas\n")
    f.write("="*50+"\n")
  end

end
