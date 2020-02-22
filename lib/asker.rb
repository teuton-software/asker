# frozen_string_literal: true

require 'rainbow'

require_relative 'asker/project'
require_relative 'asker/data/concept'
require_relative 'asker/data/world'
require_relative 'asker/ai/concept_ai'
require_relative 'asker/formatter/concept_string_formatter'
require_relative 'asker/exporter/main'
require_relative 'asker/loader/project_loader'
require_relative 'asker/loader/input_loader'

# This class does all the job
# * start
# * load_input_data
# * create_output_files, show_create_output_files
# * create_questions
# * show_final_results
class Asker
  # Initialize atributes
  def initialize
    @concepts_ai = []
    @concepts = []
    @codes = []
  end

  ##
  # Start working
  # @param args (Hash)
  def start(args = {})
    load_input_data(args)
    create_output_files
    show_final_results
  end

  ##
  # Load input data
  # @param args (Hash)
  def load_input_data(args)
    ProjectLoader.load(args)
    Project.instance.open
    data = InputLoader.load(Project.instance.get(:inputdirs).split(','))
    @concepts = data[:concepts]
    @codes = data[:codes]
    Project.instance.verbose "\n[INFO] Loading data from Internet"
    @world = World.new(@concepts)
    ConceptScreenExporter.export_all(@concepts)
  end

  ##
  # Create output files
  # * Gift
  # * YAML
  # * TXT Doc
  def create_output_files
    show_create_output_files
    create_questions
    ConceptDocExporter.new(@concepts).export
  end

  ##
  # Checking input file syntax
  # @param filename (String)
  def self.check(filename)
    puts "[TODO] Checking #{filename}"
  end

  private

  def show_create_output_files
    p = Project.instance
    p.verbose "\n[INFO] Creating output files"
    p.verbose "   ├── Gift questions file => #{Rainbow(p.outputpath).bright}"
    p.verbose "   ├── YAML questions file => #{Rainbow(p.yamlpath).bright}"
    p.verbose "   └── Lesson file         => #{Rainbow(p.lessonpath).bright}"
  end

  ##
  # Create questions for every "concept"
  # Export output to:
  # * GIFT format file
  # * YAML format file
  # Create questions for every "code"
  # Export output to GIFT format file
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

  def show_final_results
    ConceptAIScreenExporter.export_all(@concepts_ai)
    CodeScreenExporter.export_all(@codes)
    Project.instance.close
  end
end
