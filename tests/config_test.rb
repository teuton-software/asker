#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/config'

# Test Application module
class ConfigTest < Minitest::Test
  def test_params
    c = Config.new('config.ini')
    assert_equal true, c['global']['load_data_from_internet']
    assert_nil c['questions']['exclude']
  end
end
