#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/config'

# Test Application module
class ConfigTest < Minitest::Test
  def test_params
    c = Config.instance
    assert_equal true, c['global']['load_data_from_internet']
    assert_nil c['questionsl']['exclude']
  end
end
