#!/usr/bin/ruby

require 'test/unit'
require_relative '../../lib/asker/application'
require_relative '../../lib/asker/loader/project_loader'
require_relative '../../lib/asker/loader/input_loader'
require_relative '../../lib/asker/formatter/concept_string_formatter'

class ConceptStringFormatterTest < Test::Unit::TestCase

  def test_load_jedi_haml
    filepath = 'tests/input/starwars/jedi.haml'
    ProjectData.instance.reset
    Application.instance.config['global']['verbose'] = 'no'
    ProjectLoader.load(filepath)

    Rainbow.enabled = false
    data = InputLoader.load(['tests/input/starwars'])

#    t =  "+---------------+-------------------------------------------------------+\n"
#    t += "| 1             | obiwan (lang=en)                                      |\n"
    t = "| Filename      | tests/input/starwars/jedi.haml                        |\n"
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

    t2 = t.split("\n")

    b2 = ConceptStringFormatter.to_s(data[:concepts][0]).split("\n")
    b2.delete_at(0)
    b2.delete_at(0)
    t2.each_with_index do |line, index|
      assert_equal line, b2[index]
    end
    ProjectData.instance.reset
    Rainbow.enabled = true
  end
end
