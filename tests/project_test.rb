#!/usr/bin/ruby

require 'minitest/autorun'
require 'fileutils'
require_relative '../lib/project'

class ProjectTest < Minitest::Test
  def setup
    @project = Project.instance
    @project.reset
  end

  def test_defaults_parms
    assert_equal FileUtils.pwd, @project.inputbasedir
    assert_equal 'output' , @project.outputdir
    assert_equal :none    , @project.category
    assert_equal [1, 1, 1] , @project.formula_weights
    assert_equal 'en'     , @project.lang
    assert_equal 6        , @project.locales.size
    assert_equal :default , @project.show_mode
    assert_equal true     , @project.get(:verbose)
    stages = {d: true, b: true, f: true, i: true, s: true, t: true}
    assert_equal stages   , @project.stages
  end

  def test_open_project
    dirname     = "test/input/"
    projectname = "test"
    filename    = projectname+".haml"

    @project.set(:inputdirs   , [ dirname ] )
    @project.set(:process_file, filename )
    @project.set(:projectname , projectname )

    assert_equal 3, @project.param.size
    assert_equal true, @project.get(:verbose)
    @project.set(:verbose, false)
    @project.open
    @project.set(:verbose, true)
    assert_equal 13, @project.param.size
    assert_equal 11,  @project.default.size

    assert_equal filename, @project.get(:process_file)
    assert_equal filename, @project.process_file

    assert_equal "output", @project.get(:outputdir)
    assert_equal "output", @project.outputdir


    assert_equal FileUtils.pwd, @project.get(:inputbasedir)
    assert_equal FileUtils.pwd, @project.inputbasedir

    assert_equal projectname, @project.get(:projectname)
    assert_equal projectname, @project.projectname

    assert_equal projectname+"-gift.txt", @project.outputname
    assert_equal projectname+"-log.txt" , @project.logname
    assert_equal projectname+"-doc.txt" , @project.lessonname

    assert_equal File.join("output", projectname+"-gift.txt"), @project.outputpath
    assert_equal File.join("output", projectname+"-log.txt" ), @project.logpath
    assert_equal File.join("output", projectname+"-doc.txt" ), @project.lessonpath
  end
end
