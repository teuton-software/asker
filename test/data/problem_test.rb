require "test/unit"
require_relative "../../lib/asker/data/problem"

class ProblemTest < Test::Unit::TestCase
  def test_problem_new
    problem = Problem.new

    assert_equal true, problem.name.start_with?("problem")
    assert_equal false, problem.process?
    assert_equal [], problem.varnames
    assert_equal [], problem.cases
    assert_equal [], problem.descs
    assert_equal nil, problem.desc
    assert_equal [], problem.asks
    assert_equal [], problem.questions
  end

  def test_problem_from
    data = {
      fieldname: "problem_test",
      varnames: %w(N1 N2 S1),
      cases: [["2", "3", "5"]],
      descs: ["desc1", "desc2"],
      asks: [{text: "text1", answer: "answer1", steps: []}],
    }
    problem = Problem.from(data)

    assert_equal true, problem.name.start_with?("problem")
    assert_equal false, problem.process?
    assert_equal ["N1", "N2", "S1"], problem.varnames
    assert_equal [["2", "3", "5"]], problem.cases
    assert_equal ["desc1", "desc2"], problem.descs
    assert_equal "desc1", problem.desc
    assert_equal [{text: "text1", answer: "answer1", steps: []}], problem.asks
    assert_equal [], problem.questions
  end
end
