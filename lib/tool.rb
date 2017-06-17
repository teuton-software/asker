# encoding: utf-8

require 'yaml'
require 'rainbow'
require 'pry-byebug'

require_relative 'project'
require_relative 'data/concept'
require_relative 'data/world'
require_relative 'ai/concept_ai'
require_relative 'formatter/concept_string_formatter'
require_relative 'exporter/concept_ai_gift_exporter'
require_relative 'exporter/concept_ai_screen_exporter'
require_relative 'exporter/concept_doc_exporter'
require_relative 'exporter/concept_screen_exporter'
require_relative 'loader/project_loader'
require_relative 'loader/input_loader'

# This class does all the job
# Organize the hole job, sending orders to others classes
class Tool
  def initialize
    @concepts_ai = []
    @concepts = []
    @fobs =[]
  end

  def start(args = {})
    load_input_data(args)
    create_output_files
    ConceptAIScreenExporter.new(@concepts_ai).export
    Project.instance.close
  end

  def load_input_data(args)
    ProjectLoader.load(args)
    Project.instance.open
    data = InputLoader.load
    @concepts = data[:concepts]
    @fobs = data[:fobs]
    print "\n[INFO] Loading data from Internet"
    @world = World.new(@concepts)
    ConceptScreenExporter.export(@concepts)
  end

  def create_output_files
    Project.instance.verbose "\n"
    Project.instance.verbose '[INFO] Creating output files'
    text = Rainbow(Project.instance.outputpath).bright
    Project.instance.verbose '   ├── Gift questions file = ' + text
    text = Rainbow(Project.instance.lessonpath).bright
    Project.instance.verbose '   └── Lesson file         = ' + text

    create_questions
    ConceptDocExporter.new(@concepts).export
  end

  private

  def create_questions
    @concepts.each do |concept|
      concept_ai = ConceptAI.new(concept, @world)
      concept_ai.make_questions
      ConceptAIGiftExporter.new(concept_ai).export
      @concepts_ai << concept_ai
    end
    @fobs.each { |fob| fob.make_questions }
  end

  def debug
    @concepts.each do |c|
      binding.pry if c.process
    end
  end
end
