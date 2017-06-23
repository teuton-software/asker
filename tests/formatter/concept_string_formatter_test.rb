#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/loader/project_loader'
require_relative '../../lib/loader/input_loader'
require_relative '../../lib/formatter/string_color_filter'
require_relative '../../lib/formatter/concept_string_formatter'

class ConceptStringFormatterTest < Minitest::Test
  def test_load_jedi_haml
    filepath = 'tests/input/starwars/jedi.haml'
    project = Project.instance
    project.reset
    ProjectLoader.load(filepath)
    project.set(:verbose, false)
    project.set(:color_output, false)

    data = InputLoader.load

    t =  "+---------------+-------------------------------------------------------+\n"
    t += "| 1             | obiwan (lang=en)                                      |\n"
    t += "| Filename      | tests/input/starwars/jedi.haml                        |\n"
    t += "| Context       | character, starwars                                   |\n"
    t += "| Tags          | jedi, teacher, annakin, skywalker, pupil, quigon-jinn |\n"
    t += "| Reference to  |                                                       |\n"
    t += "| Referenced by |                                                       |\n"
    t += "| .def(text)    | Jedi, teacher of Annakin  Skywalker                   |\n"
    t += "|               | Jedi, pupil of Quigon-Jinn                            |\n"
    t += "| .def(images)  | 0                                                     |\n"
    t += "| .tables       | $attribute$value                                      |\n"
    t += "| .neighbors    |                                                       |\n"
    t += "+---------------+-------------------------------------------------------+\n"

    f = StringColorFilter.filter(ConceptStringFormatter.to_s(data[:concepts][0]))
    assert_equal t, f
    project.reset
  end
end
