require_relative "directory_loader"
require_relative "../ai/concept_ai"
require_relative "../ai/problem_ai"
require_relative "../data/world"

class InputLoader
  ##
  # Load input data from every input directory
  # @param inputdirs (Array)
  def call(inputdirs, internet = true)
    data = {
      world: nil,
      concepts: [], codes: [], problems: [],
      concepts_ai: [], codes_ai: []
    }
    inputdirs.each do |dirname|
      loaded = DirectoryLoader.call(dirname)
      data[:concepts] += loaded[:concepts]
      data[:codes] += loaded[:codes]
      data[:problems] += loaded[:problems]
    end
    create_questions(data, internet)
  end

  private

  def create_questions(data, internet)
    # Create World data. Calculate concept neighbours
    # TODO: Calculate code and problem neighbours
    data[:world] = World.new(data[:concepts], internet)

    # Create ConceptAI data (ConceptAI = concept + questions)
    data[:concepts].each do |concept|
      data[:concepts_ai] << ConceptAI.new(concept, data[:world])
    end

    # Create CodeAI data (CodeAI = code + questions)
    data[:codes].each do |code|
      data[:codes_ai] << CodeAIFactory.get(code)
    end

    # Fill problem with questions
    data[:problems].each { |problem| ProblemAI.new.call(problem) }

    data
  end
end
