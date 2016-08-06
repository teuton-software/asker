#!/usr/bin/ruby
# encoding: utf-8

require 'yaml'
require 'rainbow'

require_relative 'project'
require_relative 'concept/concept'
require_relative 'ia/concept_ia'
require_relative 'formatter/concept_doc_formatter'
require_relative 'formatter/concept_gift_formatter'
require_relative 'formatter/concept_string_formatter'
require_relative 'formatter/concept_screen_formatter'
require_relative 'formatter/concept_ia_screen_formatter'
require_relative 'loader/project_loader'
require_relative 'loader/input_loader'

class Tool

  def initialize
    @concepts=[]
    @concepts_ia=[]
  end

  def start(pArgs={})
    load_input_data(pArgs)
    create_output_files
    ConceptIAScreenFormatter.new(@concepts_ia).export
	  Project.instance.close
  end

  def load_input_data(pArgs)
    ProjectLoader::load(pArgs)
    Project.instance.open
    @concepts = InputLoader.new.load
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
      concept_ia = ConceptIA.new(concept)
      concept_ia.make_questions_from_ia
      ConceptGiftFormatter.new(concept_ia).export
      @concepts_ia << concept_ia
    end
  end

  def create_lesson
    @concepts_ia.each do |concept_ia|
      ConceptDocFormatter.new(concept_ia.concept).export
    end
  end

end
