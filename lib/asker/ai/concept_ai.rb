# frozen_string_literal: true

require_relative '../lang/lang'
require_relative 'ai'
require_relative 'question'

# ConceptAI: Add more info to every Concept instance.
#            Encapsulating AI data => questions
# * concept
# * questions
# * num
# * random_image_for
class ConceptAI
  include AI

  attr_reader :concept
  attr_reader :questions
  attr_reader :excluded_questions

  ##
  # Initialize ConcepAI
  # @param concept (Concept)
  # @param world (World)
  def initialize(concept, world)
    @concept = concept
    @world = world
    @questions = { d: [], b: [], f: [], i: [], s: [], t: [] }
    @excluded_questions = { d: [], b: [], f: [], i: [], s: [], t: [] }
    @num = 0 # Add a unique number to every question
    make_questions
  end

  ##
  # Generates and return new "num" value
  def num
    @num += 1
    @num.to_s
  end

  # If a method call is missing, then delegate to concept parent.
  def method_missing(method, *args, &block)
    raise "[DEBUG] ConceptAI.#{method}(#{args})"
    @concept.send(method, *args, &block)
  end

  ##
  # Generates random image URL
  def random_image_for(_conceptname)
    return '' if rand <= Project.instance.get(:threshold)

    keys = @world.image_urls.keys
    keys.shuffle!
    values = @world.image_urls[keys[0]] # keys[0] could be conceptname
    return '' if values.nil?

    values.shuffle!
    "<img src=\"#{values[0]}\" alt=\"image\"><br/>"
  end
end
