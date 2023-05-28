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
  def self.load(xmldata, filepath)
    data = read_problemdata_from_xml(xmldata, File.basename(filepath))
    puts "[DEBUG] Loading problem data"
    pp data
    Problem.from(data)
  end

  private_class_method def self.read_problemdata_from_xml(xmldata, filename)
    data = {
      filename: filename,
      varnames: [],
      cases: [],
      descs: [],
      questions: [],
      steps: []
    }
    xmldata.elements.each do |i|
      if i.name == "varnames"
        data[:varnames] = i.text.split(",")
      elsif i.name == "case"
        data[:cases] << i.text.split(",")
      elsif i.name == "desc"
        data[:descs] << i.text
      elsif i.name == "question"
        data[:questions] << read_question(i, filename)
      elsif i.name == "step"
        data[:steps] << i.text
      else
        msg = Rainbow("[ERROR] Unkown tag! problem/#{i.name} (from #{filename})").color(:red)
        Logger.verboseln msg
      end
    end
    data
  end

  private_class_method def self.read_question(xmldata, filename)
    question = { text: "?", answer: "?" }
    xmldata.elements.each do |i|
      if i.name == "text"
        question[:text] = i.text
      elsif i.name == "answer"
        question[:answer] = i.text
      else
        msg = Rainbow("[ERROR] Unkown tag! problem/question/#{i.name} (from #{filename})").color(:red)
        Logger.verboseln msg
      end
    end
    question
  end
end
