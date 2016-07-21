#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'
require_relative "../lib/concept"
require_relative "../lib/concept/table"

class TestResult < Minitest::Test
  def setup
    string_data = get_xml_data
    @concept=[]
    root_xml_data=REXML::Document.new(string_data)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name="concept" then
        @concept << Concept.new(xml_data, "pFilename", "en", [])
      end
    end
  end

  def test_names
    assert_equal "obiwan", @concept[0].name
    assert_equal "obiwan", @concept[0].names[0]

    assert_equal "yoda", @concept[1].name
    assert_equal "yoda", @concept[1].names[0]
  end

  def test_tags
    lTags = [ 'jedi', 'teacher', 'annakin', 'skywalker', 'pupil', 'quigon-jinn']
    assert_equal lTags.size, @concept[0].tags.size
    assert_equal lTags, @concept[0].tags

    lTags = [ 'teacher', 'jedi' ]
    assert_equal lTags.size, @concept[1].tags.size
    assert_equal lTags, @concept[1].tags
  end

  def test_texts
    assert_equal 2, @concept[0].texts.size
    def_text="Jedi, teacher of Annakin  Skywalker"
    assert_equal def_text, @concept[0].text
    assert_equal def_text, @concept[0].texts[0]

    assert_equal 4, @concept[1].texts.size
    def_text= [ "Jedi, teacher of all jedis" ,
                "The Main Teacher of Jedi and one of the most important members of the Main Jedi Council, in the last days of Star Republic."  ,
                "He has exceptional combat abilities with light sable, using acrobatics tecnics from Ataru." ,
                "He was master of all light sable combat styles and was considered during years as a Sword Master."
              ]
    assert_equal def_text[0], @concept[1].text
    assert_equal def_text[0], @concept[1].texts[0]
    assert_equal def_text[1], @concept[1].texts[1]
  end

  def test_tables
    name = "$attribute$value"
    assert_equal 1, @concept[0].tables.size
    assert_equal name, @concept[0].tables[0].name
    assert_equal 1, @concept[1].tables.size
    assert_equal name, @concept[1].tables[0].name
  end

  def get_xml_data
    string_data=<<EOF
    <map lang='en' context='character, starwars' version='1'>

      <concept>
        <names>obiwan</names>
        <tags>jedi, teacher, annakin, skywalker, pupil, quigon-jinn</tags>
        <def>Jedi, teacher of Annakin  Skywalker</def>
        <def>Jedi, pupil of Quigon-Jinn</def>
        <table fields='attribute, value'>
          <row>
            <col>race</col>
            <col>human</col>
          </row>
          <row>
            <col>laser sabel color</col>
            <col>green</col>
          </row>
          <row>
            <col>hair color</col>
            <col>red</col>
          </row>
        </table>
      </concept>

      <concept>
        <names>yoda</names>
        <tags>teacher, jedi</tags>
        <def>Jedi, teacher of all jedis</def>
        <def>The Main Teacher of Jedi and one of the most important members of the Main Jedi Council, in the last days of Star Republic.</def>
        <def>He has exceptional combat abilities with light sable, using acrobatics tecnics from Ataru.</def>
        <def>He was master of all light sable combat styles and was considered during years as a Sword Master.</def>
        <table fields='attribute, value'>
          <row>
            <col>laser sabel color</col>
            <col>green</col>
          </row>
          <row>
            <col>hair color</col>
            <col>white</col>
          </row>
          <row>
            <col>skin color</col>
            <col>green</col>
          </row>
          <row>
            <col>high</col>
            <col>65 centimetres</col>
          </row>
        </table>
      </concept>
    </map>
EOF
  end
end
