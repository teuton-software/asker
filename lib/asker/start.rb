require_relative "application"
require_relative "logger"
require_relative "displayer/concept_displayer"
require_relative "displayer/stats_displayer"
require_relative "exporter/output_file_exporter"
require_relative "loader/project_loader"
require_relative "loader/input_loader"

class Start
  def call(filepath)
    project_data, data = load_input(filepath)
    ConceptDisplayer.show(data[:concepts])
    create_output(project_data, data)
  end

  private

  def load_input(args)
    init_project_data
    project_data = ProjectLoader.load(args)
    init_logger(project_data)

    inputdirs = project_data.get(:inputdirs).split(',')
    internet = Application.instance.config['global']['internet'] == 'yes'
    data = InputLoader.new.call(inputdirs, internet)
    [project_data, data]
  end

  def init_project_data()
    project_data = ProjectData.instance
    outputdir = Application.instance.config['output']['folder']
    project_data.set(:outputdir, outputdir)

    formula_weights = Application.instance.config['ai']['formula_weights']
    project_data.set(:weights, formula_weights)
  end

  def init_logger(project)
    Logger.create(project.get(:logpath))
    Logger.instance.set_verbose(Application.instance.config['verbose'])
    # Logger.verboseln '[INFO] Project open'
    # Logger.verboseln '   ├── inputdirs    = ' + Rainbow(project.get(:inputdirs)).bright
    # Logger.verboseln '   └── process_file = ' + Rainbow(project.get(:process_file)).bright
  end

  def create_output(project, data)
    OutputFileExporter.export(data, project)
    StatsDisplayer.show(data)
    Logger.close
  end
end
