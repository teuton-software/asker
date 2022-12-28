#!/usr/bin/ruby

require 'test/unit'
require_relative '../../lib/asker/loader/project_loader'

class ProjectLoaderTest < Test::Unit::TestCase

  def test_load_jedi_haml
    filepath = 'test/input/starwars/jedi.haml'
    project = ProjectData.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 13, project.param.size
    assert_equal 'test/input/starwars', project.param[:inputdirs]
    assert_equal 'jedi.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_from_string_jedi_haml
    filepath = 'test/input/starwars/jedi.haml'
    project = ProjectData.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load_from_string(filepath)
    assert_equal 2, project.param.size
    assert_equal 'test/input/starwars', project.param[:inputdirs]
    assert_equal 'jedi.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_sith_haml
    filepath = 'test/input/starwars/sith.haml'
    project = ProjectData.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 13, project.param.size
    assert_equal 'test/input/starwars', project.param[:inputdirs]
    assert_equal 'sith.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_from_string_sith_haml
    filepath = 'test/input/starwars/sith.haml'
    project = ProjectData.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load_from_string(filepath)
    assert_equal 2, project.param.size
    assert_equal 'test/input/starwars', project.param[:inputdirs]
    assert_equal 'sith.haml', project.param[:process_file]
    project.reset
    assert_equal 0, project.param.size
  end

  def test_load_project1_yaml
    filepath = 'test/input/projects/project1.yaml'
    project = ProjectData.instance

    project.reset
    assert_equal 0, project.param.size
    ProjectLoader.load(filepath)
    assert_equal 15, project.param.size
    assert_equal 'input/es/add,input/es/idp', project.param[:inputdirs]
    assert_equal 'acceso-remoto.haml', project.param[:process_file]
    assert_equal 'test/input/projects/project1.yaml', project.param[:configfilename]
    assert_equal 'test/input/projects', project.param[:projectdir]
    project.reset
    assert_equal 0, project.param.size
  end
end
