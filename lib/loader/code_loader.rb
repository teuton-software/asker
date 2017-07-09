# encoding: utf-8

require 'rainbow'
require 'rexml/document'

require_relative '../project'
require_relative '../code/code'

# Read XML info about data Code
class CodeLoader
  attr_reader :code

  def initialize(xml_data, filename)
    @filename = filename
    @process = false
    @path = ''
    @type = :none

	  read_data_from_xml(xml_data)
    @code = Code.new(@path, @type)
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
