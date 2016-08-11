
class BaseStage

  def initialize(concept_ai)
    @concept_ai=concept_ai
  end

  def images
    @concept_ai.images
  end

  def lang
    @concept_ai.lang
  end

  def name
    @concept_ai.name
  end

  def neighbors
    @concept_ai.neighbors
  end

  def num
    @concept_ai.num
  end

  def run
    raise "Implement run method!"
  end

end
