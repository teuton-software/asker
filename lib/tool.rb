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

  def show_final_results
    ConceptAIScreenExporter.export(@concepts_ai)
    CodeScreenExporter.export(@codes)
    Project.instance.close
  end

  private

  def create_questions
    @concepts.each do |concept|
      concept_ai = ConceptAI.new(concept, @world)
      concept_ai.make_questions
      ConceptAIGiftExporter.export(concept_ai)
      @concepts_ai << concept_ai
    end
    @codes.each do |code|
      code.make_questions
      CodeGiftExporter.export(code)
    end
  end

  def debug
    @concepts.each do |c|
      puts 'binding.pry' if c.process
    end
  end
end
