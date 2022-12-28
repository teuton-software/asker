require 'test/unit'
require_relative '../lib/asker/application'

class ApplicationTest < Test::Unit::TestCase
  def setup
    @app = Application.instance.config
  end

  def test_internet_no
    assert_equal 'yes', @app['global']['internet'] unless
              Application.instance.config['global']['internet'] == 'no'
  end

  def test_internet_yes
    assert_equal 'no', @app['global']['internet'] unless
              Application.instance.config['global']['internet'] == 'yes'
  end

  def test_output
    assert_equal 'output', @app['output']['folder']
  end

  def test_show_mode
    assert_equal 'default', @app['global']['show_mode']
  end

  def test_formula_weights
    assert_equal [1, 1, 1], @app['ai']['formula_weights'].split(',').map(&:to_i)
  end

  def test_category
    assert_nil @app['questions']['category']
  end

  def test_exclude
    assert_nil @app['questions']['exclude']
  end
end
