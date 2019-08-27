
class BaseStage
  def initialize(concept_ai)
    @concept_ai = concept_ai
  end

  # If a method we call is missing, pass the call onto
  # the object we delegate to.
  def method_missing(m, *args, &block)
    @concept_ai.send(m, *args, &block)
  end

  def run
    raise 'Implement run method!'
  end
end
