# encoding: utf-8

require 'rainbow'
require_relative '../project'

# Define methods used to build new project skeleton
module Builder
  def self.create_project(projectname)
    puts "\n[INFO] Creating project <#{Rainbow(projectname).bright}>"
    projectdir = File.join('projects', projectname)
    Builder.create_dir(projectdir)

    filename = File.join(projectdir, 'config.yaml')
    if !File.exist? filename
      puts "* Creating file      => #{Rainbow(filename).color(:green)}"
      f = File.new(filename, 'w')
      f.write("---\n")
      f.write(":inputdirs: '#{Project.instance.inputbasedir}/#{projectname}'\n")
      f.write(":process_file: '#{projectname}.haml'\n")
      f.write("\n")
      f.close
    else
      puts "* Exists file! => #{Rainbow(filename).color(:yellow)}"
    end

    inputdir = "#{Project.instance.inputbasedir}/#{projectname}"
    Builder.create_dir(inputdir)
    filename = File.join(inputdir, projectname + '.haml')
    Builder.create_hamlfile(filename)
  end

  def self.create_dir(dirname)
    if !Dir.exist? dirname
      puts "* Creating directory => #{Rainbow(dirname).color(:green)}"
      Dir.mkdir(dirname)
    else
      puts "* Exists directory!  => #{Rainbow(dirname).color(:yellow)}"
    end
  end

  def self.create_hamlfile(filename)
    source = File.join(File.dirname(__FILE__), 'sample.haml')
    if !File.exist? filename
      puts "* Creating file      => #{Rainbow(filename).color(:green)}"
      FileUtils.cp(source, filename)
    else
      puts "* Exists file!       => #{Rainbow(dest).color(:yellow)}"
    end
  end
end
