#!/usr/bin/ruby

require 'minitest/autorun'
require 'fileutils'
require_relative '../lib/asker/project'
require_relative '../lib/asker/application'

class ProjectTest < Minitest::Test
  def setup
    @project = Project.instance
    @project.reset
  end

  def test_defaults_parms
    assert_equal FileUtils.pwd, @project.inputbasedir
    assert_equal [1, 1, 1] , @project.formula_weights
    stages = {d: true, b: true, f: true, i: true, s: true, t: true}
    assert_equal stages   , @project.stages
  end

  def test_open_project
    dirname     = "test/input/"
    projectname = "test"
    filename    = projectname + '.haml'

    @project.set(:inputdirs   , [ dirname ] )
    @project.set(:process_file, filename )
    @project.set(:projectname , projectname )

    assert_equal 3, @project.param.size
    Application.instance.config['global']['verbose'] = 'no'
    @project.open
    Application.instance.config['global']['verbose'] = 'yes'
    assert_equal 15, @project.param.size
    assert_equal 5,  @project.default.size

    assert_equal filename, @project.get(:process_file)
    assert_equal FileUtils.pwd, @project.get(:inputbasedir)
    assert_equal projectname, @project.get(:projectname)

    assert_equal projectname+"-gift.txt", @project.get(:outputname)
    assert_equal projectname+"-log.txt" , @project.get(:logname)
    assert_equal projectname+"-doc.txt" , @project.get(:lessonname)

    assert_equal File.join("output", projectname+"-gift.txt"), @project.get(:outputpath)
    assert_equal File.join("output", projectname+"-log.txt" ), @project.get(:logpath)
    assert_equal File.join("output", projectname+"-doc.txt" ), @project.get(:lessonpath)
  end
end
