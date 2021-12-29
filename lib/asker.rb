# frozen_string_literal: true

require 'rainbow'

require_relative 'asker/skeleton'
require_relative 'asker/input_checker'

require_relative 'asker/displayer/concept_displayer'
require_relative 'asker/displayer/stats_displayer'
require_relative 'asker/exporter/output_file_exporter'
require_relative 'asker/logger'

require_relative 'asker/loader/project_loader'
require_relative 'asker/loader/input_loader'

class Asker
  ##
  # Create asker input demo files
  # @param dirpath (String)
  def self.create_input(dirpath)
    Skeleton.create_input(dirpath)
  end

  ##
  # Create default asker configuration files
  def self.create_configuration
    Skeleton.create_configuration
  end

  ##
  # Checking input file syntax
  # @param filepath (String)
  def self.check(filepath)
    InputChecker.check(filepath)
  end

  ##
  # Start working
  # @param filepath (String) HAML or XML filepath
  def self.start(filepath)
    project_data, data = load_input(filepath)
    ConceptDisplayer.show(data[:concepts])
    create_output(project_data, data)
  end

  private_class_method def self.load_input(args)
    project_data = ProjectData.instance
    outputdir = Application.instance.config['output']['folder']
    project_data.set(:outputdir, outputdir)

    project_data = ProjectLoader.load(args)
    create_logger(project_data)

    inputdirs = project_data.get(:inputdirs).split(',')
    data = InputLoader.load(inputdirs)
    [project_data, data]
  end

  private_class_method def self.create_logger(project_data)
    # Create log file where to save log messages
    Logger.create(project_data.get(:logpath),
                  project_data.get(:logname))
    Logger.verboseln '[INFO] Project open'
    Logger.verboseln '   ├── inputdirs    = ' + Rainbow(project_data.get(:inputdirs)).bright
    Logger.verboseln '   └── process_file = ' + Rainbow(project_data.get(:process_file)).bright
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  private_class_method def self.create_output(project, data)
    Logger.verboseln "\n[INFO] Creating output files"
    m = '   ├── Gift questions file => '
    m += if Application.instance.config['output']['gift'] == 'yes'
           Rainbow(project.get(:outputpath)).bright
         else
           "#{project.get(:outputpath)} (No)"
         end
    Logger.verboseln m

    m = '   ├── Lesson file         => '
    m += if Application.instance.config['output']['doc'] == 'yes'
           Rainbow(project.get(:lessonpath)).bright
         else
           "#{project.get(:lessonpath)} (No)"
         end
    Logger.verboseln m

    m = '   ├── YAML questions file => '
    m += if Application.instance.config['output']['yaml'] == 'yes'
           Rainbow(project.get(:yamlpath)).bright
         else
           "#{project.get(:yamlpath)} (No)"
         end
    Logger.verboseln m

    m = '   └── Moodle XML file     => '
    m += if Application.instance.config['output']['moodle'] == 'yes'
           Rainbow(project.get(:moodlepath)).bright
         else
           "#{project.get(:moodlepath)} (No)"
         end
    Logger.verboseln m
    OutputFileExporter.export(data, project)
    StatsDisplayer.show(data)
    Logger.close
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity
end
