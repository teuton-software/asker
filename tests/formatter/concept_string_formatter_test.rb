#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/asker/application'
require_relative '../../lib/asker/loader/project_loader'
require_relative '../../lib/asker/loader/input_loader'
# require_relative '../../lib/asker/formatter/string_color_filter'
require_relative '../../lib/asker/formatter/concept_string_formatter'

class ConceptStringFormatterTest < Minitest::Test
  def test_load_jedi_haml
    filepath = 'tests/input/starwars/jedi.haml'
    Project.instance.reset
    Application.instance.config['global']['verbose'] = 'no'
    ProjectLoader.load(filepath)

    Rainbow.enabled = false
    data = InputLoader.load(['tests/input/starwars'])

    t =  "+---------------+-------------------------------------------------------+\n"
    t += "| 1             | obiwan (lang=en)                                      |\n"
    t += "| Filename      | tests/input/starwars/jedi.haml                        |\n"
    t += "| Context       | character, starwars                                   |\n"
    t += "| Tags          | jedi, teacher, annakin, skywalker, pupil, quigon-jinn |\n"
    t += "| Reference to  |                                                       |\n"
    t += "| Referenced by |                                                       |\n"
    t += "| .def(text)    | Jedi, teacher of Annakin  Skywalker                   |\n"
    t += "|               | Jedi, pupil of Quigon-Jinn                            |\n"
    t += "| .tables       | $attribute$value                                      |\n"
    t += "| .neighbors    | yoda(44.44)                                           |\n"
    t += "|               | sidious(44.44)                                        |\n"
    t += "|               | maul(22.22)                                           |\n"
    t += "+---------------+-------------------------------------------------------+\n"

    assert_equal t, ConceptStringFormatter.to_s(data[:concepts][0])
    Project.instance.reset
    Rainbow.enabled = true
  end
end
