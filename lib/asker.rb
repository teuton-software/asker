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

##
# Asker main class
class Asker
  ##
  # Create asker input demo files
  # @param dirpath (String)
  def self.create_skeleton(dirpath)
    Skeleton.create(dirpath)
  end

  ##
  # Checking input file syntax
  # @param filepath (String)
  def self.check(filepath)
    Checker.check(filepath)
  end

  ##
  # Start working
  # @param args (String)  or Hash
  def self.start(args)
    project, data = load_input_data(args)
    create_output_files(project, data)
    show_final_results(project, data)
  end

  private

  ##
  # Load input data
  # @param args (Hash)
  def self.load_input_data(args)
    project = ProjectLoader.load(args)
    project.open
    data = InputLoader.load(project.get(:inputdirs).split(','))
    data[:world] = World.new(data[:concepts])
    ConceptScreenExporter.export_all(data[:concepts], project.get(:show_mode))
    [project, data]
  end

  ##
  # Create output files
  # * Gift
  # * YAML
  # * TXT Doc
  # rubocop:disable Metrics/AbcSize
  def self.create_output_files(project, data)
    Logger.verbose "\n[INFO] Creating output files"
    Logger.verbose '   ├── Gift questions file => ' +
                   Rainbow(project.get(:outputpath)).bright
    Logger.verbose '   ├── YAML questions file => ' +
                   Rainbow(project.get(:yamlpath)).bright
    Logger.verbose '   └── Lesson file         => ' +
                   Rainbow(project.get(:lessonpath)).bright

    data[:concepts_ai] = []
    data[:concepts].each do |concept|
      concept_ai = ConceptAI.new(concept, data[:world])
      concept_ai.make_questions
      data[:concepts_ai] << concept_ai
    end
    ConceptAIGiftExporter.export_all(data[:concepts_ai])
    ConceptAIYAMLExporter.export_all(data[:concepts_ai])
    CodeGiftExporter.export_all(data[:codes]) # UNDER DEVELOPMENT
    ConceptDocExporter.new(data[:concepts]).export
  end
  # rubocop:enable Metrics/AbcSize

  def self.show_final_results(project, data)
    ConceptAIScreenExporter.export_all(data[:concepts_ai])
    CodeScreenExporter.export_all(data[:codes])
    project.close
  end
end
