#!/usr/bin/ruby

require "minitest/autorun"
require 'rexml/document'
require_relative "../lib/concept"

class TestResult < Minitest::Test
  def setup
    string_data=<<EOF
    <map>
      <concept>
        <names>obiwan</names>
        <tags>starwars, character, human, jedi</tags>
        <def>[*] is a human jedi from StarWars film.</def>
      </concept>
   </map>
EOF
    @concept=[]
    root_xml_data=REXML::Document.new(string_data)
    root_xml_data.root.elements.each do |xml_data|
      if xml_data.name="concept" then
        @concept << Concept.new(xml_data, "pFilename", "en", [])
      end
    end
  end

  def test_init_params
    assert_equal "obiwan", @concept[0].name
    assert_equal 4, @concept[0].tags.size
    #assert_equal "hola", @concept1.def
  end

end
