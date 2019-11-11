#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/asker/loader/project_loader'
require_relative '../../lib/asker/loader/input_loader'

class InputLoaderTest < Minitest::Test
  def test_load_jedi_haml
    filepath = 'tests/input/starwars/jedi.haml'
    project = Project.instance
    project.reset
    project.set(:verbose, false)
    ProjectLoader.load(filepath)

    data = InputLoader.load
    assert_equal 4, data[:concepts].size
    assert_equal 'obiwan', data[:concepts][0].name
    assert_equal 'yoda', data[:concepts][1].name
    assert_equal 'sidious', data[:concepts][2].name
    assert_equal 'maul', data[:concepts][3].name

    assert_equal true, data[:concepts][0].process?
    assert_equal true, data[:concepts][1].process?
    assert_equal false, data[:concepts][2].process?
    assert_equal false, data[:concepts][3].process?
    assert_equal 0, data[:codes].size

    project.reset
  end
end
