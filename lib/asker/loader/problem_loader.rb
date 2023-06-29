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
      asks: [],
      formats: {}
    }
    xmldata.elements.each do |i|
      case i.name
      when "cases"
        sep = i.attributes["sep"]&.strip || ","
        data[:varnames] = i.attributes["varnames"].split(sep)
        data[:varnames].map! { _1.strip }
        data[:cases] = read_cases(i, filename, sep)
      when "desc"
        data[:descs] << i.text
        type = i.attributes["type"]
        unless type.nil?
          key = "desc#{data[:descs].size}"
          data[:formats][key] = type
        end
      when "ask"
        data[:asks] << read_ask(i, filename)
      else
        Logger.warn "ProblemLoader: Unknown tag problem/#{i.name} (#{filename})"
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
        type = i.attributes["type"]
        ask[:answer_type] = type unless type.nil?
      elsif i.name == "step"
        ask[:steps] << i.text
      else
        Logger.warn "ProblemLoader: Unknown tag problem/ask/#{i.name} (#{filename})"
      end
    end
    ask
  end

  def read_cases(xmldata, filename, sep)
    cases = []

    xmldata.elements.each do |i|
      if i.name == "case"
        cases << i.text.split(sep).map { _1.strip }
      else
        Logger.warn "ProblemLoader: Unknown tag problem/cases/#{i.name} (#{filename})"
      end
    end
    cases
  end
end
