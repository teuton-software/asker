# encoding: utf-8

require_relative 'file_loader'

# Define method used to load data from directory
module DirectoryLoader
  def self.load(dirname)
    DirectoryLoader.dir_error(dirname) unless Dir.exist? dirname

    files = (Dir.new(dirname).entries - ['.', '..']).sort
    # accept only HAML or XML files
    accepted = files.select { |f| f[-4..-1] == '.xml' || f[-5..-1] == '.haml' }
    Project.instance.verbose ' * Input directory  = ' + Rainbow(dirname).bright

    output = DirectoryLoader.load_files(accepted, dirname)
    output
  end

  def self.dir_error(dirname)
    msg = '[' + Rainbow(ERROR).color(:red)
    msg += "] <#{Rainbow(dirname).color(:red)}> directory dosn't exist!"
    Project.instance.verboseln msg
    raise msg
  end

  def self.load_files(accepted, dirname)
    project = Project.instance
    output = { concepts: [], codes: [] }
    accepted.each do |f|
      filename = File.join(dirname, f)
      if f == accepted.last
        project.verbose '   └── Input file   = ' + Rainbow(filename).bright
      else
        project.verbose '   ├── Input file   = ' + Rainbow(filename).bright
      end
      data = FileLoader.load(filename)
      output[:concepts] += data[:concepts]
      output[:codes] += data[:codes]
    end
    output
  end
end
