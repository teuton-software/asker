#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/application'

# Test Application module
class ApplicationTest < Minitest::Test
  def test_params
    assert_equal 'asker',  Application.instance.name
    assert_equal '2.0.0', Application.instance.version
  end
end
