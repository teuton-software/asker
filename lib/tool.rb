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
require_relative 'loader/concept_loader'
require_relative 'loader/project_loader'

class Tool

  def initialize
    @concepts={}
    @concepts_ia=[]
  end

  def start(pArgs={})
    ProjectLoader::load(pArgs)
    Project.instance.open
    @concepts = ConceptLoader.new.load
    ConceptScreenFormatter.new(@concepts).export

    create_output_files
    ConceptIAScreenFormatter.new(@concepts_ia).export

	  Project.instance.close
  end

 def create_output_files
   Project.instance.verbose "\n"
   Project.instance.verbose "[INFO] Creating output files..."
   Project.instance.verbose "   ├── Gift questions file = "+Rainbow(Project.instance.outputpath).bright
   Project.instance.verbose "   └── Lesson file         = "+Rainbow(Project.instance.lessonpath).bright

   @concepts.each_value do |concept|
     concept_ia = ConceptIA.new(concept)
     concept_ia.make_questions_from_ia
     ConceptGiftFormatter.new(concept_ia).export
     @concepts_ia << concept_ia
   end

   @concepts_ia.each do |concept_ia|
     ConceptDocFormatter.new(concept_ia.concept).export
   end
 end

end
