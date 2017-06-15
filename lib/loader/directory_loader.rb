# encoding: utf-8

require_relative 'file_loader'

# Define method used to load data from directory
module DirectoryLoader
  def self.load(dirname)
    output = { concepts: [], fobs: [] }
    project = Project.instance

    unless Dir.exist? dirname
      msg = '[' + Rainbow(ERROR).color(:red)
      msg += "] <#{Rainbow(dirname).color(:red)}> directory dosn't exist!"
      project.verboseln msg
      raise msg
    end

    files = (Dir.new(dirname).entries - ['.', '..']).sort
    # accept only HAML or XML files
    accepted = files.select { |f| f[-4..-1] == '.xml' || f[-5..-1] == '.haml' }
    project.verbose ' * Input directory  = ' + Rainbow(dirname).bright

    accepted.each do |f|
      filename = File.join(dirname, f)
      if f == accepted.last
        project.verbose '   └── Input file   = ' + Rainbow(filename).bright
      else
        project.verbose '   ├── Input file   = ' + Rainbow(filename).bright
      end
      data = FileLoader.new(filename).load
      output[:concepts] += data[:concepts]
      output[:fobs] += data[:fobs]
    end
    output
  end
end
