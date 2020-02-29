# frozen_string_literal: true

require 'rainbow'

require_relative 'asker/exporter/concept_screen_exporter'
require_relative 'asker/exporter/output_file_exporter'
require_relative 'asker/exporter/stats_screen_exporter'
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

  ##
  # Load input data
  # @param args (Hash)
  private_class_method def self.load_input(args)
    project = ProjectLoader.load(args)
    project.open # Open output files
    data = InputLoader.load(project.get(:inputdirs).split(','))
    [project, data]
  end

  ##
  # Create output files: Gift, YAML, TXT Doc
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  private_class_method def self.create_output(project, data)
    Logger.verbose "\n[INFO] Creating output files"
    Logger.verbose '   ├── Gift questions file => ' +
                   Rainbow(project.get(:outputpath)).bright
    Logger.verbose '   ├── YAML questions file => ' +
                   Rainbow(project.get(:yamlpath)).bright
    Logger.verbose '   └── Lesson file         => ' +
                   Rainbow(project.get(:lessonpath)).bright
    OutputFileExporter.export(data, project)
    StatsScreenExporter.export(data, project.get(:show_mode))
    project.close # Logger use Project.get(:logfile) until the end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
