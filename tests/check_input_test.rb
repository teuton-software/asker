#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/asker/check_input'

class CheckInputTest < Minitest::Test
  def test_check
    assert_equal false, InputChecker.check('docs/examples/bands/david.haml', false)
    assert_equal true,  InputChecker.check('docs/examples/bands/acdc.haml', false)
  end
end
