#!/usr/bin/ruby
# encoding: utf-8

require 'yaml'
require 'rainbow'

require_relative 'project'
require_relative 'data/concept'
require_relative 'data/world'
require_relative 'ai/concept_ai'
require_relative 'formatter/concept_doc_formatter'
require_relative 'formatter/concept_ai_gift_formatter'
require_relative 'formatter/concept_string_formatter'
require_relative 'formatter/concept_screen_formatter'
require_relative 'formatter/concept_ai_screen_formatter'
require_relative 'loader/project_loader'
require_relative 'loader/input_loader'

class Tool

  def initialize
    @concepts=[]
    @concepts_ai=[]
  end

  def start(pArgs={})
    load_input_data(pArgs)
    create_output_files
    ConceptAIScreenFormatter.new(@concepts_ai).export
	  Project.instance.close
  end

  def load_input_data(pArgs)
    ProjectLoader::load(pArgs)
    Project.instance.open
    @concepts = InputLoader.new.load
    Project.instance.verbose "\n[INFO] Loading data from Internet..."
    @world    = World.new(@concepts)
    ConceptScreenFormatter.new(@concepts).export
  end

  def create_output_files
    Project.instance.verbose "\n"
    Project.instance.verbose "[INFO] Creating output files..."
    Project.instance.verbose "   ├── Gift questions file = "+Rainbow(Project.instance.outputpath).bright
    Project.instance.verbose "   └── Lesson file         = "+Rainbow(Project.instance.lessonpath).bright

    create_questions
    create_lesson
  end

private

  def create_questions
    @concepts.each do |concept|
      concept_ai = ConceptAI.new(concept,@world)
      concept_ai.make_questions_from_ai
      ConceptAIGiftFormatter.new(concept_ai).export
      @concepts_ai << concept_ai
    end
  end

  def create_lesson
    @concepts_ai.each do |concept_ai|
      ConceptDocFormatter.new(concept_ai.concept).export
    end
  end

  def debug
    @concepts.each do |c|
      if c.process then
        binding.pry
      end
    end
  end

end
