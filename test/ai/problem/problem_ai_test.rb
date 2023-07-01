require "test/unit"
require_relative "../../../lib/asker/ai/problem/problem_ai"
require_relative "../../../lib/asker/data/problem"

class ProblemAITest < Test::Unit::TestCase
  def setup
    data0 = {
      varnames: %w(N1 N2 S1),
      cases: [["2", "3", "5"]],
      descs: ["Calculate"],
      asks: [{text: "N1 + N2", answer: "S1", steps: []}],
    }
    data1 = {
      varnames: %w(N1 N2),
      cases: [["2", "3"], ["4", "5"]],
      descs: ["Calculate"],
      asks: [{text: "N1 + N2", answer: "N1 + N2", answer_type: "formula", steps: []}],
    }
    @problems= []
    @problems[0] = Problem.from(data0)
    @problems[1] = Problem.from(data1)
  end

  def test_problem_ai_call_problem_0
    problem = @problems[0]
    assert_equal 0, problem.questions.size
    ProblemAI.new.call(problem)
    assert_equal 2, problem.questions.size
  end

  def test_problem_ai_call_problem_1
    problem = @problems[1]
    assert_equal 0, problem.questions.size
    p = ProblemAI.new
    p.call(problem)
    assert_equal 6, problem.questions.size
  end
end
