#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

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
    </map>
    }
    @concepts = []
    root_xml_data=REXML::Document.new(string_concept)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="concept" then
        @concepts << Concept.new( xml_data, 'input.haml')
      end
    end

  end

  def test_rows_table_0
    r=[  [ 'race',              'human' ],
         [ 'laser sabel color' ,'green' ],
         [ 'hair color'        ,'red'   ]
      ]
    table = @concepts[0].tables[0]

    assert_equal r.size, table.datarows.size

    table.datarows.each_with_index do |row,index|
      assert_equal table.id, row.table.id
      id = row.table.id+"."+row.index.to_s
      assert_equal id,            row.id
      assert_equal index,         row.index
      assert_equal r[index],      row.raws
      assert_equal r[index].size, row.columns.size
      assert_equal r[index][0],   row.columns[0].raw
      assert_equal r[index][1],   row.columns[1].raw

      assert_equal true, row.simple[:type]
      assert_equal true, row.simple[:lang]
    end
  end

  def test_rows_table_1
    r=[ ['The Phantom Menace'], ['Attack of the Clones'], ['Revenge of the Sith'],
        ['A New Hope'], ['The Empire Strikes Back'], ['Return of the Jedi'],
        ['The Force Awakens']
      ]
    table = @concepts[0].tables[1]
    assert_equal r.size, table.datarows.size

    table.datarows.each_with_index do |row,index|
      assert_equal table.id, row.table.id
      id = row.table.id+"."+row.index.to_s
      assert_equal id,            row.id
      assert_equal index,         row.index
      assert_equal r[index],      row.raws
      assert_equal r[index].size, row.columns.size
      assert_equal r[index][0],   row.columns[0].raw

      assert_equal true, row.simple[:type]
      assert_equal true, row.simple[:lang]
    end
  end

end
