
require_relative "../lang/lang_factory"
require_relative "question"

class ProblemAI
  attr_accessor :problem
  attr_accessor :questions

  def initialize(problem)
    @lang = LangFactory.instance.get("es")
    @problem = problem
    @questions = []
  end
end
