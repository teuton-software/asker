#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/asker/loader/project_loader'

class ProjectLoaderTest < Minitest::Test
  def test_load_jedi_haml
    filepath = 'tests/input/starwars/jedi.haml'
    project = Project.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 13, project.param.size
    assert_equal 'tests/input/starwars', project.param[:inputdirs]
    assert_equal 'jedi.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_from_string_jedi_haml
    filepath = 'tests/input/starwars/jedi.haml'
    project = Project.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load_from_string(filepath)
    assert_equal 2, project.param.size
    assert_equal 'tests/input/starwars', project.param[:inputdirs]
    assert_equal 'jedi.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_sith_haml
    filepath = 'tests/input/starwars/sith.haml'
    project = Project.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 13, project.param.size
    assert_equal 'tests/input/starwars', project.param[:inputdirs]
    assert_equal 'sith.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_from_string_sith_haml
    filepath = 'tests/input/starwars/sith.haml'
    project = Project.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load_from_string(filepath)
    assert_equal 2, project.param.size
    assert_equal 'tests/input/starwars', project.param[:inputdirs]
    assert_equal 'sith.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_project1_yaml
    filepath = 'tests/input/projects/project1.yaml'
    project = Project.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 15, project.param.size
    assert_equal 'input/es/add,input/es/idp', project.param[:inputdirs]
    assert_equal 'acceso-remoto.haml', project.param[:process_file]
    assert_equal 'tests/input/projects/project1.yaml', project.param[:configfilename]
    assert_equal 'tests/input/projects', project.param[:projectdir]
    project.reset
    assert_equal 0, project.param.size
  end
end
