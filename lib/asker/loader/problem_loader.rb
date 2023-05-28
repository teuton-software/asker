# frozen_string_literal: true

require "rainbow"
require "rexml/document"
require_relative "../logger"
require_relative "../data/problem"

module ProblemLoader
  ##
  # Load XML data about Problem object
  # @param xmldata (XML Object)
  # @param filepath (String)
  # @return Code object
  def self.call(xmldata, filepath)
    data = read_problemdata_from_xml(xmldata, File.basename(filepath))
    Problem.from(data)
  end

  private_class_method def self.read_problemdata_from_xml(xmldata, filename)
    data = {
      filename: filename,
      varnames: [],
      cases: [],
      descs: [],
      asks: []
    }
    xmldata.elements.each do |i|
      if i.name == "varnames"
        data[:varnames] = i.text.split(",")
      elsif i.name == "case"
        data[:cases] << i.text.split(",")
      elsif i.name == "desc"
        data[:descs] << i.text
      elsif i.name == "ask"
        data[:asks] << read_ask(i, filename)
      else
        msg = Rainbow("[ERROR] Unkown tag! problem/#{i.name} (from #{filename})").color(:red)
        Logger.verboseln msg
      end
    end
    data
  end

  private_class_method def self.read_ask(xmldata, filename)
    ask = {text: nil, answer: nil, steps: []}
    xmldata.elements.each do |i|
      if i.name == "text"
        ask[:text] = i.text
      elsif i.name == "answer"
        ask[:answer] = i.text
      elsif i.name == "step"
        ask[:steps] = i.text
      else
        msg = Rainbow("[ERROR] Unkown tag! problem/ask/#{i.name} (from #{filename})").color(:red)
        Logger.verboseln msg
      end
    end
    ask
  end
end
