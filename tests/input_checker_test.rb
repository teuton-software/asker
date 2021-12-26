#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/asker/input_checker'

class InputCheckerTest < Minitest::Test
  def test_check
    assert_equal false, InputChecker.check('docs/examples/bands/david.haml')
    assert_equal true,  InputChecker.check('docs/examples/bands/acdc.haml')
  end
end
