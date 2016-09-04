# encoding: utf-8

require 'rainbow'
require_relative '../project'

module Builder

  def self.create_project(projectname)

    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"
    projectdir="projects/#{projectname}"
    Builder::create_dir(projectdir)

    filename=projectdir+"/config.yaml"
    if !File.exists? filename
      puts "* Creating file => #{Rainbow(filename).color(:green)}"
      f=File.new(filename,'w')
      f.write("---\n")
      f.write(":inputdirs: '#{Project.instance.inputbasedir}/#{projectname}'\n")
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

    inputdir="#{Project.instance.inputbasedir}/#{projectname}"
    Builder::create_dir(inputdir)
    filename=inputdir+"/"+projectname+".haml"
    Builder::create_hamlfile(filename)
  end

  def self.create_dir(dirname)
    if !Dir.exists? dirname
      puts "* Creating directory => #{Rainbow(dirname).color(:green)}"
      Dir.mkdir(dirname)
    else
      puts "* Exists directory! => #{Rainbow(dirname).color(:yellow)}"
    end
  end

  def self.create_hamlfile(filename)
    source = File.join( File.dirname(__FILE__), "sample.haml")
    if !File.exists? filename
      puts "* Creating file => #{Rainbow(filename).color(:green)}"
      FileUtils.cp( source, filename)
    else
      puts "* Exists file!       => #{Rainbow(dest).color(:yellow)}"
    end
  end

end
