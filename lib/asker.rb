# frozen_string_literal: true

require 'rainbow'

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
  # @param filepath (String) HAML or XML filepath
  def self.start(filepath)
    project, data = load_input(filepath)
    ConceptScreenExporter.export_all(data[:concepts], project.get(:show_mode))
    create_output(project, data)
  end

  private

  ##
  # Load input data
  # @param args (Hash)
  def self.load_input(args)
    project = ProjectLoader.load(args)
    project.open
    data = InputLoader.load(project.get(:inputdirs).split(','))
    [project, data]
  end

  ##
  # Create output files: Gift, YAML, TXT Doc
  # rubocop:disable Metrics/AbcSize
  def self.create_output(project, data)
    Logger.verbose "\n[INFO] Creating output files"
    Logger.verbose '   ├── Gift questions file => ' +
                   Rainbow(project.get(:outputpath)).bright
    Logger.verbose '   ├── YAML questions file => ' +
                   Rainbow(project.get(:yamlpath)).bright
    Logger.verbose '   └── Lesson file         => ' +
                   Rainbow(project.get(:lessonpath)).bright
    ConceptAIGiftExporter.export_all(data[:concepts_ai])
    CodeGiftExporter.export_all(data[:codes]) # UNDER DEVELOPMENT
    ConceptAIYAMLExporter.export_all(data[:concepts_ai])
    ConceptDocExporter.new(data[:concepts]).export
    # show_final_results
    ConceptAIScreenExporter.export_all(data[:concepts_ai])
    CodeScreenExporter.export_all(data[:codes])
    project.close
  end
  # rubocop:enable Metrics/AbcSize
end
