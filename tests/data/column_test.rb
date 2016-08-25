#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'
require 'pry'

require_relative "../../lib/data/concept"

class ColumnTest < Minitest::Test
  def setup
    string_concept=%q{
    <map>
      <concept>
        <names>Concept1</names>
        <tags>tag,for,concept,1</tags>
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
          <row>La amenaza fantasma</row>
          <row>El ataque de los clones</row>
          <row>La venganza de los Sith</row>
          <row>Una nueva esperanza</row>
          <row>El imperio contraataca</row>
          <row>El retorno del Jedi</row>
          <row>El despertar de la fuerza</row>
        </table>
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
  end

  def test_table_0
    r=[  [ 'race',              'human' ],
         [ 'laser sabel color' ,'green' ],
         [ 'hair color'        ,'red'   ]
      ]

    table = @concepts[0].tables[0]

    assert_equal r.size, table.rowobjects.size

    table.rowobjects.each_with_index do |row,index|
      assert_equal index,         row.index
      assert_equal r[index],      row.raws
      assert_equal r[index].size, row.columns.size
      assert_equal r[index][0],   row.columns[0].raw
      assert_equal r[index][1],   row.columns[1].raw
    end
  end

  def test_rows_table_1
    r=[ ['The Phantom Menace'], ['Attack of the Clones'], ['Revenge of the Sith'],
        ['A New Hope'], ['The Empire Strikes Back'], ['Return of the Jedi'],
        ['The Force Awakens']
      ]
  end

end
