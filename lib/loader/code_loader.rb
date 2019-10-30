# encoding: utf-8

require 'rainbow'
require 'rexml/document'

require_relative '../project'
require_relative '../code/code'

# Read XML info about Code input data
class CodeLoader
  attr_reader :code

  def initialize(xml_data, filepath)
    @dirname = File.dirname(filepath)
    @filename = ''
    @process = false
    @type = :none

    @features = []
	  read_data_from_xml(xml_data)
    @code = Code.new(@dirname, @filename, @type)
    @code.features << @features
  end

  private

  def read_data_from_xml(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when 'path'
        @filename = i.text
      when 'type'
        @type = i.text.to_sym
      when 'tags'
        puts "   │   [TODO] Implement code.tags reader!"
      when 'def'
        puts "   │   [TODO] Implement code.def reader!"
      when 'features'
        read_features(i)
      else
        text = "   [ERROR] <#{i.name}> unkown XML attribute for Code #{@filename}"
        msg = Rainbow(text).color(:red)
        Project.instance.verbose msg
      end
    end
  end

  def read_features(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when 'row'
        @features << i.text
      else
        text = "   [ERROR] <features/#{i.name}> unkown XML attribute for Code #{@filename}"
        msg = Rainbow(text).color(:red)
        Project.instance.verbose msg
      end
    end
  end
end
