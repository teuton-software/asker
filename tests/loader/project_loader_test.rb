#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/loader/project_loader'

class ProjectLoaderTest < Minitest::Test

  def setup
    @args  = ['tests/input/jedi.haml', 'tests/input/sith.haml']
  end

  def test_load_jedi
    project = Project.instance
    assert_equal 0, project.param.size

    ProjectLoader.load(@args[0])
    assert_equal 2, project.param.size
  end
end
