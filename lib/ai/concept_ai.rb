# encoding: utf-8

require_relative '../lang/lang'
require_relative 'ai'
require_relative 'question'

class ConceptAI
  include AI

  attr_reader :concept, :questions

  def initialize(concept, world)
    @concept   = concept
    @world     = world
    @questions = {}
    @num       = 0 # Used to add a unique number to every question
  end

  def method_missing(m, *args, &block)
    return @concept.data[m]
  end

  def lang
    return @concept.lang
  end

  def name(option=:raw)
    return @concept.name(option)
  end

  def type
    return @concept.type
  end

  def names
    return @concept.names
  end

  def neighbours
    return @concept.neighbours
  end

  def num
    @num+=1
    return @num.to_s
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
