require_relative "directory_loader"
require_relative "../ai/concept_ai"
require_relative "../data/world"

module InputLoader
  ##
  # Load input data from every input directory
  # @param inputdirs (Array)
  def self.call(inputdirs, internet = true)
    data = {
      world: nil,
      concepts: [], codes: [], problems: [],
      concepts_ai: [], codes_ai: [], problems_ai: []
    }
    inputdirs.each do |dirname|
      loaded = DirectoryLoader.call(dirname)
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

    # Create ProblemAI data (ProblemAI = problem + questions)
    data[:problems].each do |problem|
      # FIXME
      data[:problems_ai] << problem # ProblemAIFactory.get(problem)
    end
    data
  end
end
