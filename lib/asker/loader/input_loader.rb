# frozen_string_literal: true

require_relative 'directory_loader'
require_relative '../ai/concept_ai'
require_relative '../data/world'
require_relative '../logger'

# Load DATA defined into our Project
module InputLoader
  ##
  # Load input data from every input directory
  # @param inputdirs (Array)
  def self.load(inputdirs)
    data = { concepts: [], codes: [], world: nil, concepts_ai: [] }
    Logger.verbose "\n[INFO] Loading input data"

    # inputdirs = project.inputdirs.split(',')
    inputdirs.each do |dirname|
      temp = DirectoryLoader.load(dirname)
      data[:concepts] += temp[:concepts]
      data[:codes] += temp[:codes]
    end
    # Create World data
    # * Calculate concept neighbours
    # * TO-DO: Calculate code neighbours
    data[:world] = World.new(data[:concepts])
    # Create ConceptAI data and make concept questions
    data[:concepts].each do |concept|
      concept_ai = ConceptAI.new(concept, data[:world])
      concept_ai.make_questions
      data[:concepts_ai] << concept_ai
    end
    # Make code questions
    data[:codes].each { |code| code.make_questions }
    data
  end
end
