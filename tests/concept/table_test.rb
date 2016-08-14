#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

require_relative "../../lib/concept/concept"
require_relative "../../lib/concept/table"

class TableTest < Minitest::Test
  def setup
    string_concept=%q{
    <map>
      <concept>
        <names>Concept1</names>
        <tags>tag,for,concept,1</tags>
      </concept>
    </map>
    }
    concepts = []
    root_xml_data=REXML::Document.new(string_concept)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="concept" then
        concepts << Concept.new( xml_data, "filename")
      end
    end

    string_datas = get_xml_data
    @tables=[]
    root_xml_data=REXML::Document.new(string_datas)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="table" then
        @tables << Table.new( concepts[0], xml_data)
      end
    end
  end

  def test_table_0
    name = "$attribute$value"

    assert_equal name,  @tables[0].name
    assert_equal 'en',  @tables[0].lang.lang
    assert_equal nil,   @tables[0].title
    assert_equal false, @tables[0].sequence?
    assert_equal 0,     @tables[0].sequence.size
    assert_equal [],    @tables[0].sequence
    assert_equal 2,     @tables[0].fields.size
    assert_equal ["attribute","value"], @tables[0].fields
  end

  def test_table_0_rows
    rows=[  [ 'race',              'human' ],
             [ 'laser sabel color' ,'green' ],
             [ 'hair color'        ,'red'   ]
          ]

    assert_equal rows.size, @tables[0].rows.size
    rows.each_with_index do |row,index|
      assert_equal row, @tables[0].rows[index]
    end
  end

  def test_table_1
    name = "$film name"
    table = @tables[1]

    assert_equal name,  table.name
    assert_equal nil,   table.title
    assert_equal true,  table.sequence?
    assert_equal 1,     table.sequence.size
    assert_equal ["Films ordered by episode number"],    table.sequence
    assert_equal 1,     table.fields.size
    assert_equal ["film name"], table.fields
  end

  def test_table_1_rows
    rows=[ ['The Phantom Menace'], ['Attack of the Clones'], ['Revenge of the Sith'],
           ['A New Hope'], ['The Empire Strikes Back'], ['Return of the Jedi'],
           ['The Force Awakens']
         ]
    assert_equal rows.size, @tables[1].rows.size

    rows.each_with_index do |row,index|
      assert_equal row, @tables[1].rows[index]
    end
  end

  def get_xml_data
    string_datas=%q{
      <concept>
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
    }

    return string_datas
  end
end
