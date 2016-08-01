# encoding: utf-8

require_relative '../lang/lang'
require_relative 'ia'
require_relative '../concept/question'

class ConceptIA
  include IA

  attr_reader :concept, :questions

  def initialize(concept)
    @concept = concept
    @questions={}
    @num = 0 # Used to add a number questions
  end

  def method_missing(m, *args, &block)
    return @concept.data[m]
  end

  def lang
    return @concept.lang
  end

  def name
    return @concept.name
  end

  def neighbours
    return @concept.neighbours
  end

  def num
    @num+=1
    return @num
  end

  def process
    return @concept.process
  end

  def process?
    return @concept.process?
  end

  def tables
    return @concept.tables
  end
end
