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
require_relative 'asker/checker'
require_relative 'asker/logger'
require_relative 'asker/skeleton'

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
  # @param args (String)  or Hash
  def start(args)
    project = load_input_data(args)
    create_output_files(project)
    show_final_results
  end

  ##
  # Load input data
  # @param args (Hash)
  def load_input_data(args)
    project = ProjectLoader.load(args)
    project.open
    data = InputLoader.load(project.get(:inputdirs).split(','))
    @concepts = data[:concepts]
    @codes = data[:codes]
    Logger.verbose "\n[INFO] Loading data from Internet"
    @world = World.new(@concepts)
    ConceptScreenExporter.export_all(@concepts)
    project
  end

  ##
  # Create output files
  # * Gift
  # * YAML
  # * TXT Doc
  def create_output_files(project)
    show_create_output_files(project)
    create_questions
    ConceptDocExporter.new(@concepts).export
  end

  ##
  # Checking input file syntax
  # @param filepath (String)
  def self.check(filepath)
    Checker.check(filepath)
  end

  ##
  # Create asker input demo files
  # @param dirpath (String)
  def self.create_skeleton(dirpath)
    Skeleton.create(dirpath)
  end

  private

  # rubocop:disable Metrics/AbcSize
  def show_create_output_files(project)
    Logger.verbose "\n[INFO] Creating output files"
    Logger.verbose '   ├── Gift questions file => ' +
                   Rainbow(project.get(:outputpath)).bright
    Logger.verbose '   ├── YAML questions file => ' +
                   Rainbow(project.get(:yamlpath)).bright
    Logger.verbose '   └── Lesson file         => ' +
                   Rainbow(project.get(:lessonpath)).bright
  end
  # rubocop:enable Metrics/AbcSize

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
