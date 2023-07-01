require "test/unit"
require_relative "../../../lib/asker/ai/problem/problem_ai"
require_relative "../../../lib/asker/data/problem"
require_relative "../../../lib/asker/lang/lang_factory"

class ProblemAITest < Test::Unit::TestCase
  def setup
    data = {
      varnames: %w(N1 N2 S1),
      cases: [["2", "3", "5"]],
      descs: ["Calculate"],
      asks: [{text: "N1 + N2", answer: "S1", steps: []}],
    }
    @problems= []
    @problems[0] = Problem.from(data)
    @problems[0].lang = LangFactory.instance.get("en")
  end

  def test_problem_ai_call_problem_0
    problem = @problems[0]
    assert_equal 0, problem.questions.size
    ProblemAI.new.call(problem)
    assert_equal 2, problem.questions.size
  end
end
