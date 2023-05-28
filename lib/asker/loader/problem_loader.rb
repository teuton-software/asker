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
    problem = Problem.new(File.dirname(filepath), data[:path], data[:type])
    problem.features << data[:features]
    problem
  end

  private_class_method def self.read_problemdata_from_xml(xmldata, filename)
    data = {
      varnames: [],
      cases: [],
      desc: [],
      questions: [],
      steps: []
    }
    xmldata.elements.each do |i|
      if i.name == "varnames"
        data[:varnames] = i.text.split(",")
      elsif i.name == "cases"
        data[:cases] << i.text.split(",")
      elsif i.name == "desc"
        data[:desc] << i.text
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
    question = { text: "?", asnwer: "?" }
    xmldata.elements.each do |i|
      if i.name == "text"
        question[:text] = i.text
      elsif i.name == "asnwer"
        question[:answer] = i.text
      else
        msg = Rainbow("[ERROR] Unkown tag! problem/question/#{i.name} (from #{filename})").color(:red)
        Logger.verboseln msg
      end
    end
    question
  end
end
