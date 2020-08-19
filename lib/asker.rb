# frozen_string_literal: true

require 'rainbow'

require_relative 'asker/displayer/concept_displayer'
require_relative 'asker/displayer/stats_displayer'
require_relative 'asker/exporter/output_file_exporter'
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
  def self.create_input(dirpath)
    Skeleton.create_input(dirpath)
  end

  ##
  # Create asker configuration files
  def self.create_configuration
    Skeleton.create_configuration
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
    ConceptDisplayer.show(data[:concepts])
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
  private_class_method def self.create_output(project, data)
    Logger.verbose "\n[INFO] Creating output files"
    m = '   ├── Gift questions file => '
    if Application.instance.config['output']['gift']  == 'yes'
      m += Rainbow(project.get(:outputpath)).bright
    else
      m += "#{project.get(:outputpath)} (No)"
    end
    Logger.verbose m

    m = '   ├── Lesson file         => '
    if Application.instance.config['output']['doc']  == 'yes'
      m +=  Rainbow(project.get(:lessonpath)).bright
    else
      m += "#{project.get(:lessonpath)} (No)"
    end
    Logger.verbose m

    m = '   ├── YAML questions file => '
    if Application.instance.config['output']['yaml']  == 'yes'
      m += Rainbow(project.get(:yamlpath)).bright
    else
      m += "#{project.get(:yamlpath)} (No)"
    end
    Logger.verbose m

    m = '   └── Moodle XML file     => '
    if Application.instance.config['output']['moodle']  == 'yes'
      m += Rainbow(project.get(:moodlepath)).bright
    else
      m += "#{project.get(:moodlepath)} (No)"
    end
    Logger.verbose m


    OutputFileExporter.export(data, project)
    StatsDisplayer.show(data)
    Logger.close
  end
  # rubocop:enable Metrics/AbcSize
end
