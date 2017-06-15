#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/loader/project_loader'
require_relative '../../lib/loader/file_loader'

class FileLoaderTest < Minitest::Test
  def test_load_jedi
    filepath = 'tests/input/jedi.haml'
    project = Project.instance
    project.reset
    project.set(:verbose, false)
    ProjectLoader.load(filepath)

    data = FileLoader.load filepath

    assert_equal 2, data[:concepts].size
    assert_equal 'obiwan', data[:concepts][0].name
    assert_equal 'yoda', data[:concepts][1].name

    assert_equal true, data[:concepts][0].process?
    assert_equal true, data[:concepts][1].process?
    assert_equal 0, data[:fobs].size

    project.reset
  end

  def test_load_sith
    project = Project.instance
    project.reset
    project.set(:verbose, false)
    ProjectLoader.load('tests/input/jedi.haml')

    data = FileLoader.load 'tests/input/sith.haml'

    assert_equal 2, data[:concepts].size
    assert_equal 'sidious', data[:concepts][0].name
    assert_equal 'maul', data[:concepts][1].name

    assert_equal false, data[:concepts][0].process?
    assert_equal false, data[:concepts][1].process?
    assert_equal 0, data[:fobs].size

    project.reset
  end
end
