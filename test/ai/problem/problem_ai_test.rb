require "test/unit"
require_relative "../../../lib/asker/ai/problem/problem_ai"
require_relative "../../../lib/asker/data/problem"

class ProblemAITest < Test::Unit::TestCase
  def setup
    @data0 = {
      varnames: %w(N1 N2 S1),
      cases: [["2", "3", "5"]],
      descs: ["Calculate"],
      asks: [{text: "N1 + N2", answer: "S1", steps: []}],
    }
    @data1 = {
      varnames: %w(N1 N2),
      cases: [["2", "3"], ["4", "5"]],
      descs: ["Calculate"],
      asks: [{text: "N1 + N2", answer: "N1 + N2", answer_type: "formula", steps: []}],
    }
  end

  def test_problem_ai_call_problem_0
    problem = Problem.from(@data0)
    assert_equal 0, problem.questions.size
    ProblemAI.new.call(problem)
    assert_equal 2, problem.questions.size
  end

  def test_problem_ai_call_problem_1
    problem = Problem.from(@data1)
    assert_equal 0, problem.questions.size
    p = ProblemAI.new
    p.call(problem)
    assert_equal 6, problem.questions.size
  end
end
