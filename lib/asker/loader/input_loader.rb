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
    data = { concepts: [], codes: [], world: nil,
             concepts_ai: [], codes_ai: [] }
    Logger.verbose "\n[INFO] Loading input data"
    inputdirs.each do |dirname|
      temp = DirectoryLoader.load(dirname)
      data[:concepts] += temp[:concepts]
      data[:codes] += temp[:codes]
    end
    create_questions(data)
  end

  private_class_method def self.create_questions(data)
    # Create World data
    # * Calculate concept neighbours
    # * TO-DO: Calculate code neighbours
    data[:world] = World.new(data[:concepts])
    # Create ConceptAI data (ConceptAI = concept + questions)
    data[:concepts].each do |concept|
      data[:concepts_ai] << ConceptAI.new(concept, data[:world])
    end
    # Create CodeAI data (CodeAI = code + questions)
    data[:codes].each do |code|
      data[:codes_ai] << CodeAIFactory.get(code)
    end
    data
  end
end
