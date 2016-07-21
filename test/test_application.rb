#!/usr/bin/ruby

require "minitest/autorun"
require_relative "../lib/application"

class TestResult < Minitest::Test
  def setup
    @app = Application.instance
  end

  def test_init_params
    assert_equal "darts-of-teacher", @app.name
    assert_equal "0.8.0", @app.version
    assert_equal "input", @app.param[:inputbasedir]
  end

  def test_fill_param_with_default_values
    dirname     = "path/to/dir/"
    projectname = "myfile"
    filename    = projectname+".haml"

    @app.param[:projectdir]  = dirname
    @app.param[:process_file] = filename

    assert_equal 3, @app.param.size
    @app.fill_param_with_default_values
    assert_equal 14, @app.param.size

    assert_equal dirname , @app.param[:projectdir]
    assert_equal dirname , @app.projectdir

    assert_equal filename, @app.param[:process_file]
    assert_equal filename, @app.process_file

    assert_equal "output", @app.param[:outputdir]
    assert_equal "output", @app.outputdir

    assert_equal "input", @app.param[:inputbasedir]
    assert_equal "input", @app.inputbasedir

    assert_equal projectname, @app.param[:projectname]
    assert_equal projectname, @app.projectname

    assert_equal @app.projectname+"-gift.txt", @app.outputname
    assert_equal @app.projectname+"-log.txt" , @app.logname
    assert_equal @app.projectname+"-doc.txt" , @app.lesson_file

    assert_equal :none    , @app.category
    assert_equal [1,1,1]  , @app.formula_weights
    assert_equal 'en'     , @app.lang
    assert_equal :default , @app.show_mode
    assert_equal true     , @app.verbose
  end
end
