#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'

require_relative '../../lib/asker/data/concept'
require_relative '../../lib/asker/data/template'

class TemplateTest < Minitest::Test
  def setup
    string_concept=%q{
    <map>
      <concept>
        <names>Concept1</names>
        <tags>tag,for,concept,1</tags>

        <table fields='sentence, description'>
          <template ADJECTIVE='red,small,dirty'>
            <row>
              <col>My hat is ADJECTIVE</col>
              <col>The adjective of this sentence is ADJECTIVE</col>
            </row>
          </template>
        </table>

        <table fields='sentence, description'>
          <template SUBJECT='Bob,Mary' VERB='plays,loves'>
            <row>
              <col>SUBJECT VERB basketball.</col>
              <col>The subject is SUBJECT, and the verb is VERB.</col>
            </row>
          </template>
        </table>
      </concept>
    </map>
    }
    @concepts = []
    root_xml_data=REXML::Document.new(string_concept)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name == 'concept'
        @concepts << Concept.new(xml_data, 'input.haml')
      end
    end
  end

  def test_row_table_0
    r=[  [ 'My hat is red',   'The adjective of this sentence is red' ],
         [ 'My hat is small', 'The adjective of this sentence is small' ],
         [ 'My hat is dirty', 'The adjective of this sentence is dirty' ]
      ]
    table = @concepts[0].tables[0]

    assert_equal r.size, table.datarows.size

    table.datarows.each_with_index do |row,index|
      assert_equal index,         row.index
      assert_equal r[index],      row.raws
      assert_equal r[index].size, row.columns.size
      assert_equal r[index][0],   row.columns[0].raw
      assert_equal r[index][1],   row.columns[1].raw
    end
  end

  def test_row_table_1
    r=[  [ 'Bob plays basketball.',  'The subject is Bob, and the verb is plays.' ],
         [ 'Mary loves basketball.', 'The subject is Mary, and the verb is loves.' ],
      ]
    table = @concepts[0].tables[1]

    assert_equal r.size, table.datarows.size

    table.datarows.each_with_index do |row,index|
      assert_equal index,         row.index
      assert_equal r[index],      row.raws
      assert_equal r[index].size, row.columns.size
      assert_equal r[index][0],   row.columns[0].raw
      assert_equal r[index][1],   row.columns[1].raw
    end
  end
end
