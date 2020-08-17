#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

require_relative "../../../lib/asker/ai/stages/base_stage"
require_relative "../../../lib/asker/data/concept"
require_relative "../../../lib/asker/data/world"
require_relative "../../../lib/asker/ai/concept_ai"

class BaseStageTest < Minitest::Test
  def setup
    string_data = get_xml_data
    concepts    = []
    world       = World.new(concepts, false)
    root_xml_data=REXML::Document.new(string_data)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name="concept" then
        concepts << Concept.new(xml_data, "input.haml", "en", [])
      end
    end

    @concepts_ai=[]
    concepts.each { |concept| @concepts_ai << ConceptAI.new(concept,world) }
    @base_stages=[]
    @concepts_ai.each { |concept_ai| @base_stages << BaseStage.new(concept_ai) }
  end

  def test_base_stage_delegating
    (0..3).each do |index|
      b = @base_stages[index]
      c = @concepts_ai[index]

      assert_equal c.type            , b.type
      assert_equal c.lang.code       , b.lang.code
      assert_equal c.name            , b.name
      assert_equal c.name(:raw)      , b.name(:raw)
      assert_equal c.name(:decorated), b.name(:decorated)
      assert_equal c.name(:id)       , b.name(:id)
      assert_equal c.texts           , b.texts
      assert_equal c.images          , b.images
      assert_equal c.neighbors       , b.neighbors
    end
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

      <concept>
        <names>maul</names>
        <tags>lord, sith</tags>
        <def type="image_url">http://maul.pgn</def>
      </concept>

      <concept>
        <names>starwars films</names>
        <tags>starwars, films</tags>
        <table fields='film name' sequence='Films ordered by episode number'>
          <row>The Phantom Menace</row>
          <row>Attack of the Clones</row>
          <row>Revenge of the Sith</row>
          <row>A New Hope</row>
          <row>The Empire Strikes Back</row>
          <row>Return of the Jedi</row>
          <row>The Force Awakens</row>
        </table>
      </concept>
    </map>
EOF
  end
end
