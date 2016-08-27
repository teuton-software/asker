
class BaseStage

  def initialize(concept_ai)
    @concept_ai=concept_ai
  end

  # If a method we call is missing, pass the call onto
  # the object we delegate to.
  def method_missing(m, *args, &block)
    @concept_ai.send(m, *args, &block)
  end

  def neighbors
    @concept_ai.neighbors
  end

  def random_image_for(concept)
    @concept_ai.random_image_for(concept)
  end

  def run
    raise "Implement run method!"
  end

end
