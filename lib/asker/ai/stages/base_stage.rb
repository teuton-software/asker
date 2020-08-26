# frozen_string_literal: true

# Base Stage class
class BaseStage
  #
  # Initialize Stage with ConceptAI
  # @param concept_ai (ConceptAI)
  def initialize(concept_ai)
    @concept_ai = concept_ai
  end

  def run
    raise 'Implement run method!'
  end

  def concept
    @concept_ai
  end

  def name(option = :raw)
    @concept_ai.name(option)
  end

  def names
    @concept_ai.names
  end

  def num
    @concept_ai.num
  end

  def lang
    @concept_ai.lang
  end

  def type
    @concept_ai.type
  end

  def texts
    raise 'texts'
    @concept_ai.texts
  end

  def images
    @concept_ai.images
  end

  def neighbors
    @concept_ai.neighbors
  end

  def random_image_for(option)
    @concept_ai.random_image_for(option)
  end
end
