
require_relative 'directory_loader'

# load DATA defined by Project
# InputLoader use DirectoryLoader
# DirectoryLoader use FileLoader
# FileLoader use ContentLoader
# ContentLoader use Concept and FOBLoader
class InputLoader
  def initialize
    @data = { concepts: [], fobs: [] }
  end

  def load
    project = Project.instance
    project.verbose "\n[INFO] Loading input data"

    inputdirs = project.inputdirs.split(',')
    inputdirs.each do |dirname|
      data = DirectoryLoader.new(dirname).load
      @data[:concepts] += data[:concepts]
      @data[:fobs] += data[:fobs]
    end

    @data
  end
end
