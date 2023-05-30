require "test/unit"
require_relative "../lib/asker/check_input"

class CheckInputTest < Test::Unit::TestCase
  def test_action_check
    checker = CheckInput.new(false)

    file = "docs/examples/bands/david.haml"
    assert_equal false, checker.check(file)
    file = "docs/examples/bands/acdc.haml"
    assert_equal true,  checker.check(file)
  end
end
