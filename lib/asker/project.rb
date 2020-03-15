# frozen_string_literal: true

require 'singleton'
require 'rainbow'
# require 'fileutils'
require_relative 'application'
require_relative 'logger'

# Contains Project data and methods
class Project
  include Singleton
  attr_reader :default, :param

  ##
  # Initialize
  def initialize
    reset
  end

  ##
  # Reset project params
  def reset
    @default = { inputbasedir: FileUtils.pwd,
                stages: { d: true, b: true, f: true, i: true, s: true, t: true },
                threshold: 0.5 }
    @param = {}
  end

  ##
  # Get value param
  # @param key (Symbol) key
  def get(key)
    return @param[key] unless @param[key].nil?

    @default[key]
  end

  ##
  # Set value param
  # @param key (Symbol) key
  # @param value (String) value
  def set(key, value)
    @param[key] = value
  end

  ##
  # Open new project
  # * setting new params and
  # * creating output files
  # IMPORTANT: We need at least theses values
  # * process_file
  # * inputdirs
  def open
    config = Application.instance.config
    ext = File.extname(@param[:process_file]) || '.haml'
    #@param[:process_file] = @param[:process_file] ||
    #                        get(:projectdir).split(File::SEPARATOR).last + ext
    @param[:projectname] = @param[:projectname] ||
                           File.basename(@param[:process_file], ext)
    #@param[:inputdirs] = @param[:inputdirs] ||
    #                     File.join(get(:inputbasedir), @param[:projectdir])

    @param[:logname] = "#{@param[:projectname]}-log.txt"
    @param[:outputname] = "#{@param[:projectname]}-gift.txt"
    @param[:lessonname] = "#{@param[:projectname]}-doc.txt"
    @param[:yamlname] = "#{@param[:projectname]}.yaml"

    outputdir = config['global']['outputdir']
    @param[:logpath] = File.join(outputdir, get(:logname))
    @param[:outputpath] = File.join(outputdir, get(:outputname))
    @param[:lessonpath] = File.join(outputdir, get(:lessonname))
    @param[:yamlpath] = File.join(outputdir, get(:yamlname))

    Dir.mkdir(outputdir) unless Dir.exist?(outputdir)
    create_log_file
    create_output_file
    create_lesson_file
    create_yaml_file
  end

  ##
  # Close output files
  def close
    get(:logfile).close
    get(:outputfile).close
    get(:lessonfile).close
    get(:yamlfile).close
  end

  def method_missing(method, *_args, &_block)
    get(method)
  end

  private

  # create or reset logfile
  def create_log_file
    @param[:logfile] = File.open(get(:logpath), 'w')
    f = get(:logfile)
    f.write('=' * 50 + "\n")
    f.write("Created by : #{Application::NAME}")
    f.write(" (version #{Application::VERSION})\n")
    f.write("File       : #{get(:logname)}\n")
    f.write("Time       : #{Time.new}\n")
    f.write("Author     : David Vargas Ruiz\n")
    f.write('=' * 50 + "\n\n")

    Logger.verbose '[INFO] Project open'
    Logger.verbose '   ├── inputdirs    = ' + Rainbow(get(:inputdirs)).bright
    Logger.verbose '   └── process_file = ' + Rainbow(get(:process_file)).bright
  end

  # Create or reset output file
  def create_output_file
    config = Application.instance.config
    @param[:outputfile] = File.open(get(:outputpath), 'w')
    f = get(:outputfile)
    f.write('// ' + ('=' * 50) + "\n")
    f.write("// Created by : #{Application::NAME}")
    f.write(" (version #{Application::VERSION})\n")
    f.write("// File       : #{get(:outputname)}\n")
    f.write("// Time       : #{Time.new}\n")
    f.write("// Author     : David Vargas Ruiz\n")
    f.write('// ' + ('=' * 50) + "\n\n")
    category = config['questions']['category']
    f.write("$CATEGORY: $course$/#{category}\n") unless category.nil?
  end

  # Create or reset lesson file
  def create_lesson_file
    @param[:lessonfile] = File.new(get(:lessonpath), 'w')
    f = get(:lessonfile)
    f.write('=' * 50 + "\n")
    f.write("Created by : #{Application::NAME}")
    f.write(" (version #{Application::VERSION})\n")
    f.write("File       : #{get(:lessonname)}\n")
    f.write("Time       : #{Time.new}\n")
    f.write("Author     : David Vargas Ruiz\n")
    f.write('=' * 50 + "\n")
  end

  # Create or reset yaml file
  def create_yaml_file
    @param[:yamlfile] = File.open(get(:yamlpath), 'w')
  end
end
