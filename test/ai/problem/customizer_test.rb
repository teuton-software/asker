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

  def test_formula_bin2xxx
    c = Customizer.new(nil)
    assert_equal '7', c.bin2dec('111')
    assert_equal '7', c.bin2hex('111')
    assert_equal '7', c.bin2oct('111')

    assert_equal '17', c.bin2dec('10001')
    assert_equal '11', c.bin2hex('10001')
    assert_equal '21', c.bin2oct('10001')
  end

  def test_formula_hex2xxx
    c = Customizer.new(nil)
    assert_equal '111', c.hex2bin('7')
    assert_equal '7', c.hex2dec('7')
    assert_equal '7', c.hex2oct('7')

    assert_equal '10001', c.hex2bin('11')
    assert_equal '17', c.hex2dec('11')
    assert_equal '21', c.hex2oct('11')
  end

  def test_formula_oct2xxx
    c = Customizer.new(nil)
    assert_equal '111', c.oct2bin('7')
    assert_equal '7', c.oct2dec('7')
    assert_equal '7', c.oct2hex('7')

    assert_equal '10001', c.oct2bin('21')
    assert_equal '17', c.oct2dec('21')
    assert_equal '11', c.oct2hex('21')
  end
end
