require_relative "directory_loader"
require_relative "../ai/concept_ai"
require_relative "../data/world"

module InputLoader
  ##
  # Load input data from every input directory
  # @param inputdirs (Array)
  def self.load(inputdirs, internet = true)
    data = {
      concepts: [], codes: [], problems: [],
      world: nil, concepts_ai: [], codes_ai: []
    }
    inputdirs.each do |dirname|
      loaded = DirectoryLoader.load(dirname)
      data[:concepts] += loaded[:concepts]
      data[:codes] += loaded[:codes]
      data[:problems] += loaded[:problems]
    end
    create_questions(data, internet)
  end

  private_class_method def self.create_questions(data, internet)
    # Create World data
    # * Calculate concept neighbours
    # * TO-DO: Calculate code neighbours
    data[:world] = World.new(data[:concepts], internet)
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
