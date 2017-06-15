
require_relative 'directory_loader'

# load DATA defined by Project
# InputLoader use DirectoryLoader
# DirectoryLoader use FileLoader
# FileLoader use ContentLoader
# ContentLoader use Concept and FOBLoader
module InputLoader
  def self.load
    output = { concepts: [], fobs: [] }
    project = Project.instance
    project.verbose "\n[INFO] Loading input data"

    inputdirs = project.inputdirs.split(',')
    inputdirs.each do |dirname|
      data = DirectoryLoader.load(dirname)
      output[:concepts] += data[:concepts]
      output[:fobs] += data[:fobs]
    end

    output
  end
end
