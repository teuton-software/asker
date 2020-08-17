#!/usr/bin/ruby

require 'minitest/autorun'
require 'rexml/document'

require_relative '../../lib/asker/data/concept'
require_relative '../../lib/asker/data/table'

class TableTest < Minitest::Test
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
    root_xml_data = REXML::Document.new(string_concept)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name == "concept"
        @concepts << Concept.new(xml_data, "input.html", "en", ['test','table'])
      end
    end
  end

  def test_table_0
    name  = "$attribute$value"
    id    = @concepts[0].name + "." + name
    table = @concepts[0].tables[0]

    assert_equal name,   table.name
    assert_equal id,     table.id
    assert_equal 2,      table.langs.size
    assert_equal 'en',   table.langs[0].lang
    assert_equal 'en',   table.langs[0].code
    assert_equal 'en',   table.langs[1].lang
    assert_equal 'en',   table.langs[1].code
    assert_equal false,  table.sequence?
    assert_equal 0,      table.sequence.size
    assert_equal [],     table.sequence
    assert_equal 2,      table.types.size
    assert_equal 'text', table.types[0]
    assert_equal 'text', table.types[1]
    assert_equal 2,      table.fields.size
    assert_equal %w(attribute value), table.fields
  end

  def test_table_0_rows
    rows = [%w(race human),
            ['laser sabel color', 'green'],
            ['hair color', 'red']]
    table = @concepts[0].tables[0]

    assert_equal rows.size, table.rows.size
    rows.each_with_index do |row, index|
      assert_equal row, table.rows[index]
      assert_equal row, table.datarows[index].raws
    end
  end

  def test_table_1
    name  = '$film name'
    id    = @concepts[0].name + '.' + name
    table = @concepts[0].tables[1]
    sequence = ['Films ordered by episode number']

    assert_equal name,     table.name
    assert_equal id,       table.id
    assert_equal 1,        table.langs.size
    assert_equal 'es',     table.langs[0].lang
    assert_equal 'es',     table.langs[0].code
    assert_equal true,     table.sequence?
    assert_equal sequence, table.sequence
    assert_equal 1,        table.sequence.size
    assert_equal 1,        table.types.size
    assert_equal 'text',   table.types[0]
    assert_equal 1,        table.fields.size
    assert_equal ['film name'], table.fields
  end

  def test_table_1_rows
    rows = [['The Phantom Menace'], ['Attack of the Clones'], ['Revenge of the Sith'],
            ['A New Hope'], ['The Empire Strikes Back'], ['Return of the Jedi'],
            ['The Force Awakens']]
    table = @concepts[0].tables[1]
    assert_equal rows.size, table.rows.size

    rows.each_with_index do |row, index|
      assert_equal row, table.rows[index]
      assert_equal row, table.datarows[index].raws
    end
  end
end
