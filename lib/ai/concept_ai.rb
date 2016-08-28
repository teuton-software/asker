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

  # If a method we call is missing, pass the call onto
  # the object we delegate to.
  def method_missing(m, *args, &block)
    @concept.send(m, *args, &block)
  end

  def num
    @num+=1
    return @num.to_s
  end

end
