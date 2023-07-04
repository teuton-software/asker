require "test/unit"
require_relative "../../../lib/asker/ai/problem/customizer"
require_relative "../../../lib/asker/data/problem"

class CustomizerTest < Test::Unit::TestCase
  def test_customizer_no_type
    c = Customizer.new(Problem.new)
    assert_equal "2", c.call(text: "N1", custom: {"N1" => "2"})
    assert_equal "3", c.call(text: "3", custom: {})
    assert_equal "2 + 3", c.call(text: "N1 + N2", custom: {"N1" => "2", "N2" => "3"})
  end

  def test_customizer_formula
    c = Customizer.new(Problem.new)
    assert_equal "2", c.call(
      text: "N1", 
      custom: {"N1" => "2"}, 
      type: "formula"
      )
    assert_equal "5", c.call(
      text: "2 + 3", 
      custom: {}, 
      type: "formula"
      )
    assert_equal "5", c.call(
      text: "N1 + N2", 
      custom: {"N1" => "2", "N2" => "3"},
      type: "formula"
      )
  end

  def test_customizer_formula_min
    c = Customizer.new(Problem.new)
    assert_equal "1", c.call(
      text: "min(1, 2, 3)", 
      custom: {}, 
      type: "formula"
      )
    assert_equal "11", c.call(
      text: "min(VALUES)", 
      custom: {"VALUES" => "13, 12, 11"},
      type: "formula"
      )
  end
end
