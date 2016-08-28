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

  def num
    @num+=1
    return @num.to_s
  end

  # If a method we call is missing, pass the call onto
  # the object we delegate to.
  def method_missing(m, *args, &block)
    @concept.send(m, *args, &block)
  end

  def random_image_for(conceptname)
    return "" if rand<=Project.instance.get(:threshold)

    keys = @world.image_urls.keys
    keys.shuffle!
    values= @world.image_urls[ keys[0] ]
    return "" if values.nil?
    values.shuffle!
    return "<img src=\"#{values[0]}\" alt\=\"image\"><br/>"
  end

end
