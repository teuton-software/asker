require_relative "../../lang/lang_factory"
require_relative "../question"
require_relative "stage_answers"
require_relative "stage_steps"

class ProblemAI
  attr_accessor :problem

  def call(problem)
    @problem = problem

    questions = StageAnswers.new(@problem).make_questions
    @problem.stats[:answer] = questions.size
    @problem.questions = questions

    questions = StageSteps.new(@problem).make_questions
    @problem.stats[:steps] = questions.size
    @problem.questions += questions

    @problem
  end
end
