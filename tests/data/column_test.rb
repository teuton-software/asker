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
        <table fields='attribute0, value0'>
          <row>
            <col>laser sabel color</col>
            <col>green</col>
          </row>
          <row>
            <col>hair color</col>
            <col>red</col>
          </row>
        </table>

        <tags>tag,for,concept,1</tags>
        <table fields='attribute1, value1'>
          <row>
            <col>laser sabel color</col>
            <col>green</col>
          </row>
          <row>
            <col>hair color</col>
            <col lang='es'>rojo</col>
          </row>
        </table>

        <table fields='film name2' sequence='Films ordered by episode number'>
          <lang>es</lang>
          <row>Una nueva esperanza</row>
          <row>El imperio contraataca</row>
          <row>El retorno del Jedi</row>
        </table>

        <table fields='film name3' sequence='Films ordered by episode number'>
          <row>A new hope</row>
          <row lang='es'>El imperio contraataca</row>
          <row>Return of th Jedi</row>
        </table>
      </concept>
    </map>
    }

    @concepts = []
    root_xml_data=REXML::Document.new(string_concept)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="concept" then
        @concepts << Concept.new( xml_data, "input.haml", "en", ['starwars'])
      end
    end
  end

  def test_table_0
    r=[  [ 'laser sabel color' ,'green' ],
         [ 'hair color'        ,'red'   ]
    ]

    table = @concepts[0].tables[0]
    assert_equal true, table.simple[:type]
    assert_equal true, table.simple[:lang]

    table.datarows.each_with_index do |row, rowindex|
      assert_equal true, row.simple[:type]
      assert_equal true, row.simple[:lang]

      row.columns.each_with_index do |column, colindex|
        assert_equal colindex   , column.index
        assert_equal r[rowindex][colindex], column.raw
        assert_equal true       , column.simple[:type]
        assert_equal "text"     , column.type
        assert_equal true       , column.simple[:lang]
        assert_equal "en"       , column.lang.code
      end
    end
  end

  def test_table_1
    r=[  [ 'laser sabel color' ,'green' ],
         [ 'hair color'        ,'rojo'   ]
      ]
    table = @concepts[0].tables[1]
    assert_equal true, table.simple[:type]
    assert_equal false, table.simple[:lang]

    simple=[ { :lang => true,  :type => true  },
             { :lang => false, :type => true  } ]

    table.datarows.each_with_index do |row, rowindex|
      assert_equal simple[rowindex][:type], row.simple[:type]
      assert_equal simple[rowindex][:lang], row.simple[:lang]
    end

    simple=[ { :lang => [true, true], :type => [true,true]  },
             { :lang => [true,false], :type => [true,true]  } ]

    langcode=[  ['en','en'],  ['en','es'] ]

    table.datarows.each_with_index do |row, rowindex|
      row.columns.each_with_index do |column, colindex|
        assert_equal colindex                         , column.index
        assert_equal r[rowindex][colindex]            , column.raw
        assert_equal simple[rowindex][:type][colindex], column.simple[:type]
        assert_equal "text"                           , column.type
        assert_equal simple[rowindex][:lang][colindex], column.simple[:lang]
        assert_equal langcode[rowindex][colindex]     , column.lang.code
      end
    end
  end

  def test_table_2
    r=[ ['Una nueva esperanza'],
        ['El imperio contraataca'],
        ['El retorno del Jedi']
      ]
    table = @concepts[0].tables[2]
    assert_equal true  , table.simple[:type]
    assert_equal false , table.simple[:lang]

    table.datarows.each_with_index do |row, rowindex|
      assert_equal true , row.simple[:type]
      assert_equal true , row.simple[:lang]

      row.columns.each_with_index do |column, colindex|
        assert_equal colindex   , column.index
        assert_equal r[rowindex][colindex], column.raw
        assert_equal true       , column.simple[:type]
        assert_equal "text"     , column.type
        assert_equal true       , column.simple[:lang]
        assert_equal "es"       , column.lang.code
      end
    end

    def test_table_3
      r=[ ['Una nueva esperanza'],
          ['El imperio contraataca'],
          ['El retorno del Jedi']
        ]
      table = @concepts[0].tables[3]

      table.rowobjects.each_with_index do |row, rowindex|
        assert_equal true, row.simple[:type]
        assert_equal true, row.simple[:lang]

        row.columns.each_with_index do |column, colindex|
          assert_equal colindex   , column.index
          assert_equal r[rowindex][colindex], column.raw
          assert_equal true,   column.simple[:type]
          assert_equal "text", column.type
          assert_equal true,   column.simple[:lang]
          assert_equal "es" ,  column.lang.code
        end
      end
    end
  end

end
