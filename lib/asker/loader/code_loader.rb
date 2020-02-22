# frozen_string_literal: true

require 'rainbow'
require 'rexml/document'
require_relative '../logger'
require_relative '../code/code'

require 'pry-byebug'
# Read XML info about Code input data
module CodeLoader
  ##
  # Load XML data about Code object
  # @param xmldata (XML Object)
  # @param filepath (String)
  # @return Code object
  def self.load(xmldata, filepath)
    data = read_data_from_xml(xmldata, File.dirname(filepath))
    code = Code.new(File.dirname(filepath), data[:path], data[:type])
    code.features << data[:features]
    code
  end

  def self.read_data_from_xml(xmldata, filename)
    data = {}
    xmldata.elements.each do |i|
      case i.name
      when 'path'
        data[:path] = i.text
      when 'type'
        data[:type] = i.text.to_sym
      when 'features'
        # data[:features] << read_features(i)
      else
        text = "   [ERROR] Unkown attribute #{i.name} into file #{filename}"
        msg = Rainbow(text).color(:red)
        Logger.verbose msg
      end
    end
    data
  end

  ##
  # Read features data from XML input
  def self.read_features(xmldata)
    features = []
    xmldata.elements.each do |i|
      case i.name
      when 'row'
        features << i.text
      else
        text = "   [ERROR] <features/#{i.name}> unkown XML attribute for Code #{@filename}"
        msg = Rainbow(text).color(:red)
        Logger.verbose msg
      end
    end
    features
  end
end
