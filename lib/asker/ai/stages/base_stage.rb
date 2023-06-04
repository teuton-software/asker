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
    raise "Implement run method!"
  end

  def concept
    @concept_ai.concept
  end

  def name(option = :raw)
    @concept_ai.concept.name(option)
  end

  def names
    raise "Change names by concept.names"
  end

  def num
    @concept_ai.num
  end

  def lang
    raise "Change lang by concept.lang"
  end

  def type
    raise "Change type by concept.type"
  end

  def texts
    raise "Change texts by cocept.texts"
  end

  def images
    raise "Change images by cocept.images"
  end

  def neighbors
    raise "Change neighbors by concept.neighbors"
  end

  def random_image_for(option)
    @concept_ai.random_image_for(option)
  end
end
