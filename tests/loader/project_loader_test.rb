#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/loader/project_loader'

class ProjectLoaderTest < Minitest::Test
  def test_load_jedi_haml
    filepath = 'tests/input/jedi.haml'
    project = Project.instance
    project.reset

    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 2, project.param.size
    assert_equal 'tests/input', project.param[:inputdirs]
    assert_equal 'jedi.haml', project.param[:process_file]
  end

  def test_load_sith_haml
    filepath = 'tests/input/sith.haml'
    project = Project.instance
    project.reset

    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 2, project.param.size
    assert_equal 'tests/input', project.param[:inputdirs]
    assert_equal 'sith.haml', project.param[:process_file]
  end

  def test_load_project1_yaml
    filepath = 'tests/input/project1.yaml'
    project = Project.instance
    project.reset

    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 4, project.param.size
    assert_equal 'input/es/add,input/es/idp', project.param[:inputdirs]
    assert_equal 'acceso-remoto.haml', project.param[:process_file]
    assert_equal 'tests/input/project1.yaml', project.param[:configfilename]
    assert_equal 'tests/input', project.param[:projectdir]
  end
end
