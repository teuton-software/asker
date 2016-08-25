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
    table.rowobjects.each_with_index do |row, rowindex|
      assert_equal true, row.simple[:type]
      assert_equal true, row.simple[:lang]

      row.columns.each_with_index do |column, colindex|
        assert_equal r[rowindex][colindex], column.raw
        assert_equal true,   column.simple[:type]
        assert_equal "text", column.type
        binding.pry
        assert_equal true,   column.simple[:lang]
        assert_equal "es" ,  column.lang.code
      end
    end
  end

  def test_rows_table_1
    r=[ ['La amenaza fantasma'],
        ['El ataque de los clones'],
        ['La  venganza de los Sith'],
        ['Una nueva esperanza'],
        ['El imperio contraataca'],
        ['El retorno del Jedi'],
        ['El despartar de la fuerza']
      ]
    table = @concepts[0].tables[1]

    table.rowobjects.each_with_index do |row, rowindex|
      assert_equal true, row.simple[:type]
      assert_equal false, row.simple[:lang]

      row.columns.each_with_index do |column, colindex|
        assert_equal r[rowindex][colindex], column.raw
        assert_equal true,   column.simple[:type]
        assert_equal "text", column.type
        binding.pry
        assert_equal true,   column.simple[:lang]
        assert_equal "es" ,  column.lang.code
      end
    end
  end

end
