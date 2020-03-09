# frozen_string_literal: true

require 'rainbow'
require 'rexml/document'
require_relative '../logger'
require_relative '../data/code'

# Read XML info about Code input data
module CodeLoader
  ##
  # Load XML data about Code object
  # @param xmldata (XML Object)
  # @param filepath (String)
  # @return Code object
  def self.load(xmldata, filepath)
    data = read_codedata_from_xml(xmldata, File.basename(filepath))
    code = Code.new(File.dirname(filepath), data[:path], data[:type])
    code.features << data[:features]
    code
  end

  ##
  # Read Code data from XML content
  # @param xmldata (XML Object)
  # @param filename (String) File name that contains data
  # @return Code object
  private_class_method def self.read_codedata_from_xml(xmldata, filename)
    data = { path: '?', type: '?', features: [] }
    xmldata.elements.each do |i|
      data[:path] = i.text if i.name == 'path'
      data[:type] = i.text.to_sym if i.name == 'type'
      data[:features] << read_features(i, filename) if i.name == 'features'
    end
    data
  end

  ##
  # Read features data from XML input
  # @param xmldata (XML object)
  # @return Array with features (Strings)
  private_class_method def self.read_features(xmldata, filename)
    features = []
    xmldata.elements.each do |i|
      if i.name == 'row'
        features << i.text
      else
        msg = Rainbow("[ERROR] features/#{i.name} from #{filename}").color(:red)
        Logger.verbose msg
      end
    end
    features
  end
end
