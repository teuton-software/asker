#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/loader/project_loader'

class ProjectLoaderTest < Minitest::Test

  def setup
    @args  = ['tests/input/jedi.haml', 'tests/input/sith.haml']
  end

  def test_load_jedi
    project = Project.instance
    project.reset

    assert_equal 0, project.param.size
    ProjectLoader.load(@args[0])
    assert_equal 2, project.param.size
    assert_equal 'tests/input', project.param[:inputdirs]
    assert_equal 'jedi.haml', project.param[:process_file]
  end

  def test_load_sith
    project = Project.instance
    project.reset

    assert_equal 0, project.param.size
    ProjectLoader.load(@args[1])
    assert_equal 2, project.param.size
    assert_equal 'tests/input', project.param[:inputdirs]
    assert_equal 'sith.haml', project.param[:process_file]
  end
end
