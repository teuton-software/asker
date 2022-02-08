#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

require_relative "../../lib/asker/data/concept"
require_relative "../../lib/asker/data/world"
require_relative "../../lib/asker/ai/concept_ai"

class ConceptAITest < Minitest::Test
  def setup
    string_data = get_xml_data
    concepts = []
    world = World.new(concepts)
    root_xml_data = REXML::Document.new(string_data)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name == 'concept'
        concepts << Concept.new(xml_data, 'input.haml', 'en', [])
      end
    end

    @concepts = concepts
    @concepts_ai = []
    concepts.each { |concept| @concepts_ai << ConceptAI.new(concept,world) }
    @initial = { d: [], b: [], f: [], i: [], s: [], t: []}
  end

  def test_concept_0_make_questions
    i=0
    assert_equal( @initial, @concepts_ai[i].questions)
    assert_equal( @initial, @concepts_ai[i].excluded_questions)
    @concepts_ai[i].concept.process = true
    @concepts_ai[i].make_questions
    assert_equal 9, @concepts_ai[i].questions[:d].size
    assert_equal 0,  @concepts_ai[i].questions[:b].size
    assert_equal 0,  @concepts_ai[i].questions[:f].size
    assert_equal 0,  @concepts_ai[i].questions[:i].size
    assert_equal 0,  @concepts_ai[i].questions[:s].size
    assert_equal 20, @concepts_ai[i].questions[:t].size
  end

  def test_concept_1_make_questions
    i = 1
    assert_equal( @initial, @concepts_ai[i].questions)
    assert_equal( @initial, @concepts_ai[i].excluded_questions)
    @concepts_ai[i].concept.process = true
    @concepts_ai[i].make_questions
    assert_equal 25, @concepts_ai[i].questions[:d].size
    assert_equal 2,  @concepts_ai[i].questions[:b].size
    assert_equal 0,  @concepts_ai[i].questions[:f].size
    assert_equal 0,  @concepts_ai[i].questions[:i].size
    assert_equal 0,  @concepts_ai[i].questions[:s].size
    assert_equal 31, @concepts_ai[i].questions[:t].size
  end

  def test_concept_2_make_questions
    i = 2
    assert_equal( @initial, @concepts_ai[i].questions)
    assert_equal( @initial, @concepts_ai[i].excluded_questions)
    @concepts_ai[i].concept.process = true
    @concepts_ai[i].make_questions
    assert_equal 0,  @concepts_ai[i].questions[:d].size
    assert_equal 0,  @concepts_ai[i].questions[:b].size
    assert_equal 0,  @concepts_ai[i].questions[:f].size
    assert_equal 2,  @concepts_ai[i].questions[:i].size
    assert_equal 0,  @concepts_ai[i].questions[:s].size
    assert_equal 0,  @concepts_ai[i].questions[:t].size
  end

  def test_concept_3_make_questions
    i = 3
    assert_equal( @initial, @concepts_ai[i].questions)
    assert_equal( @initial, @concepts_ai[i].excluded_questions)
    @concepts_ai[i].concept.process = true
    @concepts_ai[i].make_questions
    assert_equal 0,  @concepts_ai[i].questions[:d].size
    assert_equal 0,  @concepts_ai[i].questions[:b].size
    assert_equal 20, @concepts_ai[i].questions[:f].size
    assert_equal 0,  @concepts_ai[i].questions[:i].size
    assert_equal 4,  @concepts_ai[i].questions[:s].size
    assert_equal 0,  @concepts_ai[i].questions[:t].size
  end

  def donttest_get_list1_and_list2_from_table
    world = World.new(@concepts, false)

    c = @concepts_ai[0]
    t = c.tables[0]
    list1, list2 = c.get_list1_and_list2_from(t)
    verbose list1, list2
  end

  def verbose(list1,list2)
    puts 'list1'
    puts list1
    puts 'list2'
    puts list2
  end

  def get_xml_data
    %q{
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
}
  end
end
