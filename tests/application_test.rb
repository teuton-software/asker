#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/application'

# Test Application module
class ApplicationTest < Minitest::Test
  def test_params
    assert_equal 'darts-of-teacher', Application.name
    assert_equal '0.16.1',           Application.version
  end
end
