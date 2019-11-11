#!/usr/bin/ruby

require 'minitest/autorun'
require 'rexml/document'

require_relative '../../lib/asker/data/concept'
require_relative '../../lib/asker/sinatra/formatter/concept_haml_formatter'

class ConceptHAMLFormatterTest < Minitest::Test
  def setup
    string_datas = get_xml_data
    @haml_concepts = []
    root_xml_data = REXML::Document.new(string_datas)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name == 'concept'
        @haml_concepts << ConceptHAMLFormatter.new( Concept.new(xml_data, "filename.haml") )
      end
    end

  end

  def test_haml_concept_0
    output = %q{
  %concept
    %names concept1.1, concept1.2
    %tags tag1.1, tag1.2, tag1.3
    %def definition1.1
    %def definition1.2
    %table{:fields => 'field1, field2'}
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

    assert_equal output, @haml_concepts[0].to_s
  end

  def test_haml_concept_1
    output = %q{
  %concept
    %names concept2.1
    %tags tag2.1, tag2.2, tag2.3
    %table{:fields => 'field1', :sequence => 'sequence1'}
      %row row1
      %row row2
      %row row3
}
    assert_equal output, @haml_concepts[1].to_s
  end

  def get_xml_data
    string_datas=%q{
<map>
  <concept>
    <names>concept1.1, concept1.2</names>
    <tags> tag1.1, tag1.2, tag1.3</tags>
    <def>definition1.1</def>
    <def>definition1.2</def>
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
  </concept>

  <concept>
    <names>concept2.1</names>
    <tags> tag2.1, tag2.2, tag2.3</tags>
    <table fields='field1' sequence='sequence1'>
      <row>row1</row>
      <row>row2</row>
      <row>row3</row>
    </table>
  </concept>
</map>
}

    return string_datas
  end
end
