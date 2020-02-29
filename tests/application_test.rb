#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/asker/application'

# Test Application module
class ApplicationTest < Minitest::Test
  def test_params
    assert_equal 'asker',  Application::NAME
    assert_equal 'asker-tool',  Application::GEM
    assert_equal '2.1.5', Application::VERSION
  end

  def test_config
    c = Application.instance.config
    assert_equal 'yes', c['global']['internet'] unless
              Application.instance.config['global']['internet'] == 'no'
    assert_equal 'no', c['global']['internet'] unless
              Application.instance.config['global']['internet'] == 'yes'
    assert_equal 'output', c['global']['outputdir']
    assert_nil c['questions']['exclude']
  end
end
