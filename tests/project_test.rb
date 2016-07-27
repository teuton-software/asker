#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../lib/project"

class TestResult < Minitest::Test
  def setup
    @project = Project.instance
  end

  def test_init_params
    assert_equal "input", @project.param[:inputbasedir]
  end

  def test_fill_param_with_values
    dirname     = "path/to/dir/"
    projectname = "myfile"
    filename    = projectname+".haml"

    @project.param[:projectdir]  = dirname
    @project.param[:process_file] = filename

    assert_equal 9, @project.param.size
    @project.fill_param_with_values
    assert_equal 17, @project.param.size

    assert_equal dirname , @project.param[:projectdir]
    assert_equal dirname , @project.projectdir

    assert_equal filename, @project.param[:process_file]
    assert_equal filename, @project.process_file

    assert_equal "output", @project.param[:outputdir]
    assert_equal "output", @project.outputdir

    assert_equal "input", @project.param[:inputbasedir]
    assert_equal "input", @project.inputbasedir

    assert_equal projectname, @project.param[:projectname]
    assert_equal projectname, @project.projectname

    assert_equal projectname+"-gift.txt", @project.outputname
    assert_equal projectname+"-log.txt" , @project.logname
    assert_equal projectname+"-doc.txt" , @project.lessonname

    assert_equal File.join("output", projectname+"-gift.txt"), @project.outputpath
    assert_equal File.join("output", projectname+"-log.txt" ), @project.logpath
    assert_equal File.join("output", projectname+"-doc.txt" ), @project.lessonpath

    assert_equal :none    , @project.category
    assert_equal [1,1,1]  , @project.formula_weights
    assert_equal 'en'     , @project.lang
    assert_equal :default , @project.show_mode
    assert_equal true     , @project.param[:verbose]
  end
end
