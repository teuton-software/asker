#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/application'

# Test Application module
class ApplicationTest < Minitest::Test
  def test_params
    assert_equal 'asker',  Application.name
    assert_equal '19.02.3', Application.version
  end
end
