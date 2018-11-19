#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/application'

# Test Application module
class ApplicationTest < Minitest::Test
  def test_params
    assert_equal 'darts-of-teacher', Application.name
    assert_equal '0.17.0',           Application.version
  end
end
