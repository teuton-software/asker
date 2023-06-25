require "test/unit"
require_relative "../lib/asker/check_input"

class CheckInputTest < Test::Unit::TestCase
  def setup
    @checker = CheckInput.new
    @checker.verbose = false
  end

  def tofix_test_check_fail
    filename = File.join("docs", "examples", "bands", "david.haml")
    Logger.set_verbose(false)
    # This action call exit 1
    assert_equal false, @checker.check(filename)
  end

  def test_check_ok
    filename = File.join("docs", "examples", "bands", "acdc.haml")
    Logger.set_verbose(false)
    assert_equal true, @checker.check(filename)
  end
end
