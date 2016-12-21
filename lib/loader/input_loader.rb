
require_relative 'directory_loader'

class InputLoader

  def initialize
    @concepts = []
  end

  def load
    project=Project.instance
    project.verbose "\n[INFO] Loading input data"

    inputdirs = project.inputdirs.split(',')
    inputdirs.each do |dirname|
      @concepts += DirectoryLoader.new(dirname).load
    end

    #find_neighbors_for_every_concept
    return @concepts
  end

#  def find_neighbors_for_every_concept
#    @concepts.each do |i|
#      @concepts.each do |j|
#        if (i.id!=j.id) then
#          i.try_adding_neighbor(j)
#          i.try_adding_references(j)
#        end
#      end
#    end
#  end
end
