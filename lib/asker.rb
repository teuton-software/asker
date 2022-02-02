# frozen_string_literal: true

require 'rainbow'

require_relative 'asker/skeleton'
require_relative 'asker/check_input'

require_relative 'asker/displayer/concept_displayer'
require_relative 'asker/displayer/stats_displayer'
require_relative 'asker/exporter/output_file_exporter'
require_relative 'asker/logger'

require_relative 'asker/loader/project_loader'
require_relative 'asker/loader/input_loader'

class Asker
  def self.init
    Skeleton.create_configuration
  end

  def self.new_input(dirpath)
    Skeleton.create_input(dirpath)
  end

  def self.check(filepath)
    CheckInput.check(filepath)
  end

  def self.start(filepath)
    project_data, data = load_input(filepath)
    ConceptDisplayer.show(data[:concepts])
    create_output(project_data, data)
  end

  private_class_method def self.load_input(args)
    init_project_data
    project_data = ProjectLoader.load(args)
    init_logger(project_data)

    inputdirs = project_data.get(:inputdirs).split(',')
    internet = Application.instance.config['global']['internet'] == 'yes'
    data = InputLoader.load(inputdirs, internet)
    [project_data, data]
  end

  private_class_method def self.init_project_data()
    project_data = ProjectData.instance
    outputdir = Application.instance.config['output']['folder']
    project_data.set(:outputdir, outputdir)

    formula_weights = Application.instance.config['ai']['formula_weights']
    project_data.set(:weights, formula_weights)
  end

  private_class_method def self.init_logger(project_data)
    # Create log file where to save log messages
    Logger.create(project_data.get(:logpath),
                  project_data.get(:logname))
    Logger.instance.set_verbose(Application.instance.config['verbose'])
    Logger.verboseln '[INFO] Project open'
    Logger.verboseln '   ├── inputdirs    = ' + Rainbow(project_data.get(:inputdirs)).bright
    Logger.verboseln '   └── process_file = ' + Rainbow(project_data.get(:process_file)).bright
  end

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
end
