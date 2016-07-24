# encoding: utf-8

require 'rainbow'

module ProjectBuilder

  def self.create_project(projectname, inputbasedir)

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
      f.write(":inputdirs: '#{inputbasedir}/#{projectname}'\n")
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

    inputdir="#{inputbasedir}/#{projectname}"
    if !Dir.exists? inputdir
      puts "* Creating directory => #{Rainbow(inputdir).color(:green)}"
      Dir.mkdir(inputdir)
    else
      puts "* Exists directory! => #{Rainbow(inputdir).color(:yellow)}"
    end

    filename=inputdir+"/"+projectname+".haml"
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
