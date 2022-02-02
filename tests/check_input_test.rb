#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/asker/check_input'

class CheckInputTest < Minitest::Test
  def test_action_check
    checker = CheckInput.new(false)

    file = 'docs/examples/bands/david.haml'
    assert_equal false, checker.file(file).check
    file = 'docs/examples/bands/acdc.haml'
    assert_equal true,  checker.file(file).check
  end
end
