#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../lib/asker/application'

class ApplicationTest < Minitest::Test
  def test_params
    assert_equal 'asker',  Application::NAME
    assert_equal 'asker-tool',  Application::GEM
    assert_equal String, Application::VERSION.class
  end

  def test_config
    c = Application.instance.config
    assert_equal 'yes', c['global']['internet'] unless
              Application.instance.config['global']['internet'] == 'no'
    assert_equal 'no', c['global']['internet'] unless
              Application.instance.config['global']['internet'] == 'yes'
    assert_equal 'output', c['output']['folder']
    assert_equal 'default', c['global']['show_mode']
    assert_equal [1, 1, 1], c['ai']['formula_weights'].split(',').map(&:to_i)
    assert_nil c['questions']['category']
    assert_nil c['questions']['exclude']
  end
end
