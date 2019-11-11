#!/usr/bin/ruby

require 'minitest/autorun'
require 'rexml/document'

require_relative '../../lib/asker/data/concept'
require_relative '../../lib/asker/data/table'
require_relative '../../lib/asker/sinatra/formatter/table_haml_formatter'

class TableHAMLFormatterTest < Minitest::Test
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
    @haml_tables=[]
    root_xml_data=REXML::Document.new(string_datas)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name=="table" then
        @haml_tables << TableHAMLFormatter.new( Table.new( concepts[0], xml_data) )
      end
    end
  end

  def test_haml_table_0
    output = %q{    %table{:fields => 'field1, field2'}
      %row
        %col col1.1
        %col col1.2
      %row
        %col col2.1
        %col col2.2
      %row
        %col col3.1
        %col col3.2
}
    assert_equal output, @haml_tables[0].to_s
  end

  def test_haml_table_1
    output = %q{    %table{:fields => 'field1', :sequence => 'sequence1'}
      %row row1
      %row row2
      %row row3
}
    assert_equal output, @haml_tables[1].to_s
  end

  def get_xml_data
    string_datas=%q{
      <concept>
        <table fields='field1, field2'>
          <row>
            <col>col1.1</col>
            <col>col1.2</col>
          </row>
          <row>
            <col>col2.1</col>
            <col>col2.2</col>
          </row>
          <row>
            <col>col3.1</col>
            <col>col3.2</col>
          </row>
        </table>

        <table fields='field1' sequence='sequence1'>
          <row>row1</row>
          <row>row2</row>
          <row>row3</row>
        </table>
      </concept>
    }

    return string_datas
  end
end
