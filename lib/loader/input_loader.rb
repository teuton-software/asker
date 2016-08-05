# encoding: utf-8

require 'haml'
require 'rexml/document'
require_relative 'directory_loader'

class InputLoader

  def initialize
    @concepts = {}
  end

  def load
    project=Project.instance
    project.verbose "\n[INFO] Loading input data..."

    inputdirs = project.inputdirs.split(',')
    concepts = {}
    inputdirs.each do |dirname|
      concepts = DirectoryLoader.new(dirname).load
    end
    @concepts.merge!(concepts)
    
    find_neighbors_for_every_concept
    return @concepts
  end

  def find_neighbors_for_every_concept
    #find neighbors for every concept
    @concepts.each_value do |i|
      @concepts.each_value do |j|
        i.try_adding_neighbor(j) if (i.id!=j.id)
      end
    end
  end

end
