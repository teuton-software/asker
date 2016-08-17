# encoding: utf-8

require 'singleton'
require_relative 'application'

class Project
  include Singleton
  attr_accessor :param

  def initialize
    @param={}
    @param[:inputbasedir]    = "input"
    @param[:outputdir]       = "output"
    @param[:category]        = :none
    @param[:formula_weights] = [1,1,1]
    @param[:lang]            = 'en'
    @param[:locales]         = [ 'en', 'es', 'maths' ]
    @param[:show_mode]       = :default
    @param[:verbose]         = true
    @param[:stages]          = [ :stage_d, :stage_b, :stage_c, :stage_f, :stage_i, :stage_s ]
  end

  def method_missing(m, *args, &block)
    return @param[m]
  end

  def open
    #We need at least process_file and inputdirs params
    ext = ".haml"

    @param[:process_file] = @param[:process_file] || @param[:projectdir].split(File::SEPARATOR).last + ext
    @param[:projectname]  = @param[:projectname]  || File.basename( @param[:process_file], ext)
    @param[:inputdirs]    = @param[:inputdirs]    || File.join( @param[:inputbasedir], @param[:projectdir] )

    @param[:logname]      = @param[:logname]      || "#{@param[:projectname]}-log.txt"
    @param[:outputname]   = @param[:outputname]   || "#{@param[:projectname]}-gift.txt"
    @param[:lessonname]   = @param[:lessonname]   || "#{@param[:projectname]}-doc.txt"

    @param[:logpath]      = @param[:logpath]      || File.join( @param[:outputdir], @param[:logname] )
    @param[:outputpath]   = @param[:outputpath]   || File.join( @param[:outputdir], @param[:outputname] )
    @param[:lessonpath]   = @param[:lessonpath]   || File.join( @param[:outputdir], @param[:lessonname] )

    create_log_file
    create_output_file
    create_lesson_file
  end

  def close
    @param[:logfile].close
    @param[:outputfile].close
    @param[:lessonfile].close
  end

  def verbose(lsText)
    puts lsText if @param[:verbose]
    @param[:logfile].write(lsText.to_s+"\n") if @param[:logfile]
  end

  def verboseln(lsText)
    verbose(lsText+"\n")
  end

private
  def create_log_file
    #create or reset logfile
    Dir.mkdir(@param[:outputdir]) if !Dir.exists? @param[:outputdir]

    @param[:logfile] = File.open(@param[:logpath],'w')
    f = @param[:logfile]
    f.write("="*50+"\n")
    f.write("Created by : #{Application::name} (version #{Application::version})\n")
    f.write("File       : #{@param[:logname]}\n")
    f.write("Time       : "+Time.new.to_s+"\n")
    f.write("Author     : David Vargas\n")
    f.write("="*50+"\n\n")

    verbose "[INFO] Project open"
    verbose "   ├── inputdirs    = " + Rainbow( @param[:inputdirs] ).bright
    verbose "   └── process_file = " + Rainbow( @param[:process_file] ).bright
  end

  def create_output_file
    #Create or reset output file
    Dir.mkdir(@param[:outputdir]) if !Dir.exists? @param[:outputdir]

    @param[:outputfile] = File.open(@param[:outputpath],'w')
    f = @param[:outputfile]
    f.write("// "+("="*50)+"\n")
    f.write("// Created by : #{Application::name} (version #{Application::version})\n")
    f.write("// File       : #{@param[:outputname]}\n")
    f.write("// Time       : "+Time.new.to_s+"\n")
    f.write("// Author     : David Vargas\n")
    f.write("// "+("="*50)+"\n")
    f.write("\n")
    f.write("$CATEGORY: $course$/#{@param[:category].to_s}\n") if @param[:category]!=:none
  end

  def create_lesson_file
    #Create or reset lesson file
    @param[:lessonfile] = File.new( @param[:lessonpath],'w')
    f = @param[:lessonfile]
    f.write("="*50+"\n")
    f.write("Created by : #{Application::name} (version #{Application::version})\n")
    f.write("File       : #{@param[:lessonname]}\n")
    f.write("Time       : "+Time.new.to_s+"\n")
    f.write("Author     : David Vargas\n")
    f.write("="*50+"\n")
  end

end
