#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

require_relative "../../lib/data/world"
require_relative "../../lib/data/concept"

class WorldTest < Minitest::Test

  def setup
    string_data = get_xml_data
    @concepts = []
    @context  = ['character', 'starwars']
    root_xml_data=REXML::Document.new(string_data)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="concept" then
        c = Concept.new(xml_data, "input.haml", "en", @context)
        c.process = true
        @concepts << c
      end
    end

    @world = World.new(@concepts, false) #show_progress = false
  end

  def test_concepts
    assert_equal 2    , @world.concepts.size
    assert_equal false, @world.concepts["obiwan"].nil?
    assert_equal false, @world.concepts["yoda"].nil?
    assert_equal true , @world.concepts["maul"].nil?
    assert_equal true , @world.concepts["vader"].nil?
  end

  def test_contexts
    assert_equal 1,        @world.contexts.size
    assert_equal @context, @world.contexts[0]
  end

  def test_filenames
    assert_equal 1, @world.filenames.size
    assert_equal "input.haml", @world.filenames[0]
  end

  def test_image_urls
    keys   = @world.image_urls.keys
    values = @world.image_urls.values

    assert_equal 3, keys.size
    assert_equal 3, values.size

    keys.each { |key| assert_equal String, key.class }
    values.each do |value|
      assert_equal Array, value.class
      assert_equal 20   , value.size
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
    </map>
EOF
  end
end
