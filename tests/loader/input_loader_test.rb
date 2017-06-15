#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/loader/project_loader'
require_relative '../../lib/loader/input_loader'

class InputLoaderTest < Minitest::Test
  def test_load_jedi_haml
    filepath = 'tests/input/jedi.haml'
    project = Project.instance
    project.reset
    project.set(:verbose, false)
    ProjectLoader.load(filepath)

    data = InputLoader.new.load
    assert_equal 4, data[:concepts].size
    assert_equal 'obiwan', data[:concepts][0].name
    assert_equal 'yoda', data[:concepts][1].name
    assert_equal 'sidious', data[:concepts][2].name
    assert_equal 'maul', data[:concepts][3].name

    assert_equal true, data[:concepts][0].process?
    assert_equal true, data[:concepts][1].process?
    assert_equal false, data[:concepts][2].process?
    assert_equal false, data[:concepts][3].process?
    assert_equal 0, data[:fobs].size
  end
end
