# frozen_string_literal: true

require "rexml/document"
require_relative "../logger"
require_relative "../data/problem"

class ProblemLoader
  def initialize(lang, context)
    @lang = lang
    @context = context
  end

  ##
  # Load XML data about Problem object
  # @param xmldata (XML Object)
  # @param filepath (String)
  # @return Problem object
  def call(xmldata, filepath)
    data = read_problemdata_from_xml(xmldata, File.basename(filepath))
    problem = Problem.from(data)
    problem.lang = @lang
    problem.context = @context
    problem
  end

  private

  def read_problemdata_from_xml(xmldata, filename)
    data = {
      filename: filename,
      varnames: [],
      cases: [],
      descs: [],
      asks: []
    }
    xmldata.elements.each do |i|
      case i.name
      when "cases"
        data[:varnames] = i.attributes["varnames"].split(",")
        data[:varnames].map! { _1.strip }
        data[:cases] = read_cases(i, filename)
      when "desc"
        data[:descs] << i.text
      when "ask"
        data[:asks] << read_ask(i, filename)
      else
        Logger.warn "ProblemLoader: Unkown tag problem/#{i.name} (#{filename})"
      end
    end
    data
  end

  def read_ask(xmldata, filename)
    ask = {text: nil, answer: nil, steps: []}
    xmldata.elements.each do |i|
      if i.name == "text"
        ask[:text] = i.text
      elsif i.name == "answer"
        ask[:answer] = i.text
      elsif i.name == "step"
        ask[:steps] << i.text
      else
        Logger.warn "ProblemLoader: Unkown tag problem/ask/#{i.name} (#{filename})"
      end
    end
    ask
  end

  def read_cases(xmldata, filename)
    cases = []

    xmldata.elements.each do |i|
      if i.name == "case"
        cases << i.text.split(",").map { _1.strip }
      else
        Logger.warn "ProblemLoader: Unkown tag problem/cases/#{i.name} (#{filename})"
      end
    end
    cases
  end
end
