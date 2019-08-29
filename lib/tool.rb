# frozen_string_literal: true

require 'yaml'
require 'rainbow'
# require 'pry-byebug'

require_relative 'project'
require_relative 'data/concept'
require_relative 'data/world'
require_relative 'ai/concept_ai'
require_relative 'formatter/concept_string_formatter'
require_relative 'exporter/main'
require_relative 'loader/project_loader'
require_relative 'loader/input_loader'

# This class does all the job
# Organize the hole job, sending orders to others classes
# * start
# * load_input_data
# * create_output_files, show_create_output_files
# * create_questions
# * show_final_results
class Tool
  def initialize
    @concepts_ai = []
    @concepts = []
    @codes = []
  end

  def start(args = {})
    load_input_data(args)
    create_output_files
    show_final_results
  end

  def load_input_data(args)
    ProjectLoader.load(args)
    Project.instance.open
    data = InputLoader.load
    @concepts = data[:concepts]
    @codes = data[:codes]
    Project.instance.verbose "\n[INFO] Loading data from Internet"
    @world = World.new(@concepts)
    ConceptScreenExporter.export_all(@concepts)
  end

  def create_output_files
    show_create_output_files
    create_questions
    ConceptDocExporter.new(@concepts).export
  end

  def show_create_output_files
    p = Project.instance
    p.verbose "\n[INFO] Creating output files"
    p.verbose "   ├── Gift questions file => #{Rainbow(p.outputpath).bright}"
    p.verbose "   ├── YAML questions file => #{Rainbow(p.yamlpath).bright}"
    p.verbose "   └── Lesson file         => #{Rainbow(p.lessonpath).bright}"
  end

  def show_final_results
    ConceptAIScreenExporter.export_all(@concepts_ai)
    CodeScreenExporter.export_all(@codes)
    Project.instance.close
  end

  private

  def create_questions
    @concepts.each do |concept|
      concept_ai = ConceptAI.new(concept, @world)
      concept_ai.make_questions
      @concepts_ai << concept_ai
    end
    ConceptAIGiftExporter.export_all(@concepts_ai)
    ConceptAIYAMLExporter.export_all(@concepts_ai)
    CodeGiftExporter.export_all(@codes) # UNDER DEVELOPMENT
  end
end
