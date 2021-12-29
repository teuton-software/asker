#!/usr/bin/ruby

require 'minitest/autorun'
require 'fileutils'
require_relative '../../lib/asker/data/project_data'
require_relative '../../lib/asker/application'

class ProjectDataTest < Minitest::Test
  def setup
    @project = ProjectData.instance
    @project.reset
  end

  def test_defaults_parms
    assert_equal FileUtils.pwd, @project.get(:inputbasedir)
    stages = {d: true, b: true, f: true, i: true, s: true, t: true}
    assert_equal stages   , @project.get(:stages)
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
    assert_equal 13, @project.param.size
    assert_equal 4,  @project.default.size

    assert_equal filename, @project.get(:process_file)
    assert_equal FileUtils.pwd, @project.get(:inputbasedir)
    assert_equal projectname, @project.get(:projectname)

    assert_equal "#{projectname}-gift.txt", @project.get(:outputname)
    assert_equal "#{projectname}-log.txt" , @project.get(:logname)
    assert_equal "#{projectname}-doc.txt" , @project.get(:lessonname)
    assert_equal "#{projectname}.yaml" , @project.get(:yamlname)
    assert_equal "#{projectname}-moodle.xml" , @project.get(:moodlename)

    assert_equal File.join("output", "#{projectname}-gift.txt"), @project.get(:outputpath)
    assert_equal File.join("output", "#{projectname}-log.txt" ), @project.get(:logpath)
    assert_equal File.join("output", "#{projectname}-doc.txt" ), @project.get(:lessonpath)
    assert_equal File.join("output", "#{projectname}.yaml" ), @project.get(:yamlpath)
    assert_equal File.join("output", "#{projectname}-moodle.xml" ), @project.get(:moodlepath)
  end
end
