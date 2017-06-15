# encoding: utf-8

require_relative 'file_loader'

class DirectoryLoader
  def initialize(dirname)
    @dirname = dirname
    @data = {concepts: [], fobs: []}
  end

  def load
    project = Project.instance

    dirname = @dirname
    unless Dir.exist? dirname
      msg = "["+Rainbow(ERROR).color(:red)+"] <#{Rainbow(dirname).color(:red)}> directory dosn't exist!"
      project.verboseln msg
      raise msg
    end

    files = (Dir.new(dirname).entries-[".",".."]).sort
    accepted = files.select { |f| f[-4..-1]==".xml" || f[-5..-1]==".haml" } # accept only HAML or XML files
    project.verbose " * Input directory  = " + Rainbow(dirname).bright

    accepted.each do |f|
      pFilename = File.join(dirname, f)
      if f == accepted.last
        project.verbose "   └── Input file   = " + Rainbow(pFilename).bright
      else
        project.verbose "   ├── Input file   = " + Rainbow(pFilename).bright
      end
      data = FileLoader.new(pFilename).load
      @data[:concepts] += data[:concepts]
      @data[:fobs] += data[:fobs]
    end
    @data
  end
end
