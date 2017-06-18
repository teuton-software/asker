#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/loader/project_loader'
require_relative '../../lib/loader/directory_loader'

class DirectoryLoaderTest < Minitest::Test
  def test_load_test_input_starwars
    filepath = 'tests/input/starwars/jedi.haml'
    project = Project.instance
    project.reset
    project.set(:verbose, false)
    ProjectLoader.load(filepath)

    data = DirectoryLoader.load 'tests/input/starwars'

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

    project.reset
  end

  def test_load_test_input_ruby
    filepath = 'tests/input/ruby/ruby1.haml'
    project = Project.instance
    project.reset
    project.set(:verbose, false)
    ProjectLoader.load(filepath)

    data = DirectoryLoader.load 'tests/input/ruby'

    assert_equal 0, data[:concepts].size
    assert_equal 3, data[:fobs].size
    assert_equal :ruby, data[:fobs][0].type
    assert_equal :ruby, data[:fobs][1].type
    assert_equal :ruby, data[:fobs][2].type

    assert_equal 'tests/input/files/string.rb', data[:fobs][0].filename
    assert_equal 'tests/input/files/array.rb', data[:fobs][1].filename
    assert_equal 'tests/input/files/iterador.rb', data[:fobs][2].filename

    project.reset
  end
end