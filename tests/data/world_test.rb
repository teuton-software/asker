#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

require_relative "../../lib/data/world"
require_relative "../../lib/data/concept"

class WorldTest < Minitest::Test
  def setup

    string_data = get_xml_data
    @concepts=[]
    root_xml_data=REXML::Document.new(string_data)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="concept" then
        @concepts << Concept.new(xml_data, "pFilename", "en", ['character', 'starwars'])
      end
    end

    @world = World.new(@concepts)
  end

  def test_concepts
    assert_equal 2, @world.concepts.size
    assert_equal "obiwan", @world.concepts[0]
    assert_equal "yoda", @world.concepts[1]
  end

  def test_contexts
    assert_equal 2, @world.contexts.size
    assert_equal "character", @world.contexts[0]
    assert_equal "starwars", @world.contexts[1]
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
