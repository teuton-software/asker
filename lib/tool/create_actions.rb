#!/usr/bin/ruby
# encoding: utf-8

module CreateActions

	
  def create_log_file
	app=Application.instance

    #create or reset logfile
    Dir.mkdir(app.outputdir) if !Dir.exists? app.outputdir

    @logfile=File.open(@logname,'w')
    @logfile.write("="*40+"\n")
    @logfile.write("Proyect: TeacherTools Interviewer\n")
    @logfile.write("File: #{@logname}\n")
    @logfile.write("Time: "+Time.new.to_s+"\n")
    @logfile.write("="*40+"\n")
  end
	
  def create_output_files
    app=Application.instance
    
    verbose "\n[INFO] Creating output files..."

    lFile=File.new(@outputname,'w')
    lFile.write("// File: #{@outputname}\n")
    lFile.write("// Time: "+Time.new.to_s+"\n")
    lFile.write("// Create automatically by David Vargas\n")
    lFile.write("\n")
    lFile.write("$CATEGORY: $course$/#{app.category.to_s}\n") if app.category!=:none
    @concepts.each_value do |c| 
      c.write_questions_to(lFile) if c.process?
    end
    lFile.close
		
    if app.param[:lesson_file]!=:none then
      lFile=File.new(app.outputdir+'/'+app.lesson_file,'w')
      @concepts.each_value do |c| 
        c.write_lesson_to(lFile) if c.process?
      end
      lFile.close
    end
  end
	
  def create_project(projectname)
    app=Application.instance

    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"
    projectdir="projects/#{projectname}"
    if !Dir.exists? projectdir
      puts "* Creating directory => #{Rainbow(projectdir).color(:green)}"
      Dir.mkdir(projectdir)
    else
      puts "* Exists directory! => #{Rainbow(projectdir).color(:yellow)}"
    end
    
    filename=projectdir+"/config.yaml"
    if !File.exists? filename
      puts "* Creating file => #{Rainbow(filename).color(:green)}"
      f=File.new(filename,'w')
      f.write("---\n")
      f.write(":inputdirs: '#{app.inputbasedir}/#{projectname}'\n")
      f.write(":process_file: '#{projectname}.haml'\n")
      f.write("\n")
      f.close
    else
      puts "* Exists file! => #{Rainbow(filename).color(:yellow)}"
    end
    
    filename=projectdir+"/.gitignore"
    if !File.exists? filename
      puts "* Creating file => #{Rainbow(filename).color(:green)}"
      f=File.new(filename,'w')
      f.write("*.txt\n*.log\n*.tmp\n")
      f.close
    else
      puts "* Exists file! => #{Rainbow(filename).color(:yellow)}"
    end

    mapdir="#{app.inputbasedir}/#{projectname}"
    if !Dir.exists? mapdir
      puts "* Creating directory => #{Rainbow(mapdir).color(:green)}"
      Dir.mkdir(mapdir)
    else
      puts "* Exists directory! => #{Rainbow(mapdir).color(:yellow)}"
    end
    
    filename=mapdir+"/"+projectname+".haml"
    if !File.exists? filename
      puts "* Creating file => #{Rainbow(filename).color(:green)}"
      f=File.new(filename,'w')
      f.write(DATA.read)
      f.close
    else
      puts "* Exists file! => #{Rainbow(filename).color(:yellow)}"
    end
    puts "" 
  end
  
end
