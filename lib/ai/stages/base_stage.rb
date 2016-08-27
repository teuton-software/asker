
class BaseStage

  def initialize(concept_ai)
    @concept_ai=concept_ai
  end

  def name(option=:raw)
    @concept_ai.name(option)
  end

  def lang
    @concept_ai.lang
  end

  def texts
    @concept_ai.texts
  end

  def images
    @concept_ai.images
  end

  def neighbors
    @concept_ai.neighbors
  end

  def num
    @concept_ai.num
  end

  def random_image_for(concept)
    @concept_ai.random_image_for(concept)
  end

  def run
    raise "Implement run method!"
  end

end
