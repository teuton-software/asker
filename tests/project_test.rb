#!/usr/bin/ruby

require 'pry'
require "minitest/autorun"
require_relative "../lib/project"

class ProjectTest < Minitest::Test
  def setup
    @project = Project.instance
  end

  def test_defaults
    assert_equal "input"  , @project.inputbasedir
    assert_equal "output" , @project.outputdir
    assert_equal :none    , @project.category
    assert_equal [1,1,1]  , @project.formula_weights
    assert_equal 'en'     , @project.lang
    assert_equal 3        , @project.locales.size
    assert_equal :default , @project.show_mode
    assert_equal true     , @project.get(:verbose)
    stages = [ :stage_d, :stage_b, :stage_c, :stage_f, :stage_i, :stage_s ]
    assert_equal stages   , @project.stages
  end

  def test_open
    dirname     = "test/input/"
    projectname = "jedi"
    filename    = projectname+".haml"

    @project.param[:projectdir]   = dirname
    @project.param[:inputdirs]    = [ dirname ]
    @project.param[:process_file] = filename

    assert_equal 3, @project.param.size
    assert_equal true, @project.get(:verbose)
    @project.param[:verbose] = false
    @project.open
    @project.param[:verbose] = true
    assert_equal 14, @project.param.size
    assert_equal 9, @project.default.size

    assert_equal dirname , @project.get(:projectdir)
    assert_equal dirname , @project.projectdir

    assert_equal filename, @project.get(:process_file)
    assert_equal filename, @project.process_file

    assert_equal "output", @project.get(:outputdir)
    assert_equal "output", @project.outputdir

    assert_equal "input", @project.get(:inputbasedir)
    assert_equal "input", @project.inputbasedir

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
