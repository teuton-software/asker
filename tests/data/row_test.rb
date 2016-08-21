#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'
require 'pry'

require_relative "../../lib/data/concept"
require_relative "../../lib/data/table"
require_relative "../../lib/data/row"

class RowTest < Minitest::Test
  def setup
    string_concept=%q{
    <map>
      <concept>
        <names>Concept1</names>
        <tags>tag,for,concept,1</tags>
      </concept>
    </map>
    }
    @concepts = []
    root_xml_data=REXML::Document.new(string_concept)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="concept" then
        @concepts << Concept.new( xml_data, "input.haml")
      end
    end

    string_table = %q{
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
          <lang>es</lang>
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

    @tables=[]
    root_xml_data=REXML::Document.new(string_table)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="table" then
        @tables << Table.new( @concepts[0], xml_data)
      end
    end


  end

  def test_rows_table_0
    rows=[  [ 'race',              'human' ],
            [ 'laser sabel color' ,'green' ],
            [ 'hair color'        ,'red'   ]
          ]

    assert_equal rows.size, @tables[0].rowobjects.size
    rows.each_with_index do |row,index|
      assert_equal row, @tables[0].rowobjects[index]
    end
  end

  def test_rows_table_1
    rows=[ ['The Phantom Menace'], ['Attack of the Clones'], ['Revenge of the Sith'],
           ['A New Hope'], ['The Empire Strikes Back'], ['Return of the Jedi'],
           ['The Force Awakens']
         ]
    assert_equal rows.size, @tables[1].rowobjects.size

    rows.each_with_index do |row,index|
      assert_equal row, @tables[1].rowobjects[index]
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
          <lang>es</lang>
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
