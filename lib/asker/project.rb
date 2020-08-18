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
    @param[:projectname] = @param[:projectname] ||
                           File.basename(@param[:process_file], ext)

    @param[:logname] = "#{@param[:projectname]}-log.txt"
    @param[:outputname] = "#{@param[:projectname]}-gift.txt"
    @param[:lessonname] = "#{@param[:projectname]}-doc.txt"
    @param[:yamlname] = "#{@param[:projectname]}.yaml"
    @param[:moodlename] = "#{@param[:projectname]}-moodle.xml"

    outputdir = config['global']['outputdir']
    @param[:logpath] = File.join(outputdir, get(:logname))
    @param[:outputpath] = File.join(outputdir, get(:outputname))
    @param[:lessonpath] = File.join(outputdir, get(:lessonname))
    @param[:yamlpath] = File.join(outputdir, get(:yamlname))
    @param[:moodlepath] = File.join(outputdir, get(:moodlename))

    Dir.mkdir(outputdir) unless Dir.exist?(outputdir)
    create_log_file # We will write logger messages into this file during the process
  end

  ##
  # Close log file
  def close_logfile
    get(:logfile).close
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

end
