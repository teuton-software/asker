require 'test/unit'
require_relative '../../lib/asker/application'
require_relative '../../lib/asker/loader/project_loader'
require_relative '../../lib/asker/loader/input_loader'

class InputLoaderTest < Test::Unit::TestCase

  def test_load_jedi_haml
    filepath = 'test/input/starwars/jedi.haml'
    ProjectData.instance.reset
    ProjectLoader.load(filepath)

    data = InputLoader.load(ProjectData.instance.get(:inputdirs).split(','))
    assert_equal 4, data[:concepts].size
    assert_equal 'obiwan', data[:concepts][0].name
    assert_equal 'yoda', data[:concepts][1].name
    assert_equal 'sidious', data[:concepts][2].name
    assert_equal 'maul', data[:concepts][3].name

    assert_equal true, data[:concepts][0].process?
    assert_equal true, data[:concepts][1].process?
    assert_equal false, data[:concepts][2].process?
    assert_equal false, data[:concepts][3].process?
    assert_equal 0, data[:codes].size

    ProjectData.instance.reset
    Application.instance.config['global']['verbose'] = 'yes'
  end
end
