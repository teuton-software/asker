# encoding: utf-8

require 'rainbow'
require 'rexml/document'

require_relative '../project'
require_relative '../fob/fob'

# Read XML info about data FOB
class FOBLoader
  attr_reader :fob

  def initialize(xml_data, filename)
    @filename = filename
    @process = false
    @path = ''
    @type = :none

	  read_data_from_xml(xml_data)
    @fob = FOB.new(@path, @type)
  end

  private

  def read_data_from_xml(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when 'path'
        @path = i.text
      when 'type'
        @type = i.text.to_sym
      else
        text = "   [ERROR] <#{i.name}> unkown XML attribute for FOB #{@path}"
        msg = Rainbow(text).color(:red)
        Project.instance.verbose msg
      end
    end
  end
end
