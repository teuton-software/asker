# encoding: utf-8

require 'rainbow'
require 'rexml/document'

require_relative '../project'
require_relative '../code/code'

# Read XML info about Code input data
class CodeLoader
  attr_reader :code

  def initialize(xmldata, filepath)
    @dirname = File.dirname(filepath)
    @filename = ''
    @process = false
    @type = :none

    @features = []
	  read_data_from_xml(xmldata)
    @code = Code.new(@dirname, @filename, @type)
    @code.features << @features
  end

  private

  def read_data_from_xml(xmldata)
    xmldata.elements.each do |i|
      case i.name
      when 'path'
        @filename = i.text
      when 'type'
        @type = i.text.to_sym
      when 'features'
        read_features(i)
      else
        text = "   [ERROR] <#{i.name}> unkown XML attribute for Code #{@filename}"
        msg = Rainbow(text).color(:red)
        Project.instance.verbose msg
      end
    end
  end

  ##
  # Read features data from XML input
  def read_features(xmldata)
    xmldata.elements.each do |i|
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
