#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/application'

# Test Application module
class ApplicationTest < Minitest::Test
  def test_params
    assert_equal 'asker',  Application.instance.name
    assert_equal '2.1.0', Application.instance.version
  end

  def test_config
    c = Application.instance.config
    assert_equal 'yes', c['global']['internet']
    assert_nil c['questions']['exclude']
  end
end
