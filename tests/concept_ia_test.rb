#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

require_relative "../lib/concept/concept"
require_relative "../lib/ia/concept_ia"

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

    @concept_ia=[]
    @concept.each { |concept| @concept_ia << ConceptIA.new(concept) }
  end

  def test_make_questions_from_ia
    @concept_ia.each { |c| assert_equal( {}, c.questions) }
    @concept[0].process = true
    @concept_ia[0].make_questions_from_ia
    assert_equal 13, @concept_ia[0].questions[:stage_a].size
    assert_equal 0, @concept_ia[0].questions[:stage_b].size
    assert_equal 20, @concept_ia[0].questions[:stage_c].size
    assert_equal 0, @concept_ia[0].questions[:stage_d].size
    assert_equal 0, @concept_ia[0].questions[:stage_e].size

    @concept[1].process = true
    @concept_ia[1].make_questions_from_ia
    assert_equal 27, @concept_ia[1].questions[:stage_a].size
    assert_equal 2, @concept_ia[1].questions[:stage_b].size
    assert_equal 31, @concept_ia[1].questions[:stage_c].size
    assert_equal 0, @concept_ia[1].questions[:stage_d].size
    assert_equal 0, @concept_ia[1].questions[:stage_e].size
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
