# frozen_string_literal: true

require 'singleton'
require 'rainbow'
require 'fileutils'
require_relative 'application'

# Contains Project data and methods
class Project
  include Singleton
  attr_reader :default, :param
  attr_accessor :fobs

  ##
  # Initialize
  def initialize
    reset
  end

  ##
  # Reset project params
  def reset
    @default = {}
    @default[:inputbasedir] = FileUtils.pwd
    @default[:outputdir] = 'output'
    @default[:category] = :none
    @default[:formula_weights] = [1, 1, 1]
    @default[:lang] = 'en'
    @default[:locales] = %w[en es javascript math python ruby sql]
    @default[:show_mode] = :default
    @default[:verbose] = true
    @default[:stages] = { d: true, b: true, f: true, i: true, s: true, t: true }
    @default[:threshold] = 0.5
    @default[:color_output] = true
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
    ext = '.haml'
    @param[:process_file] = @param[:process_file] ||
                            get(:projectdir).split(File::SEPARATOR).last + ext
    @param[:projectname] = @param[:projectname] ||
                           File.basename(@param[:process_file], ext)
    @param[:inputdirs] = @param[:inputdirs] ||
                         File.join(get(:inputbasedir), @param[:projectdir])

    @param[:logname] = @param[:logname] ||
                       "#{@param[:projectname]}-log.txt"
    @param[:outputname] = @param[:outputname] ||
                          "#{@param[:projectname]}-gift.txt"
    @param[:lessonname] = @param[:lessonname] ||
                          "#{@param[:projectname]}-doc.txt"
    @param[:yamlname] = @param[:yamlname] ||
                        "#{@param[:projectname]}.yaml"

    @param[:logpath] = @param[:logpath] ||
                       File.join(get(:outputdir), @param[:logname])
    @param[:outputpath] = @param[:outputpath] ||
                          File.join(get(:outputdir), @param[:outputname])
    @param[:lessonpath] = @param[:lessonpath] ||
                          File.join(get(:outputdir), @param[:lessonname])
    @param[:yamlpath] = @param[:yamlpath] ||
                        File.join(get(:outputdir), @param[:yamlname])

    Dir.mkdir(get(:outputdir)) unless Dir.exist?(get(:outputdir))
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

  ##
  # Log and display text
  def verbose(msg)
    puts msg if get(:verbose)
    get(:logfile).write(msg.to_s + "\n") if get(:logfile)
  end

  ##
  # Log and display text line
  def verboseln(msg)
    verbose(msg + "\n")
  end

  def method_missing(method, *_args, &_block)
    get(method)
  end

  private

  def create_log_file
    # create or reset logfile
    @param[:logfile] = File.open(get(:logpath), 'w')
    f = get(:logfile)
    f.write('=' * 50 + "\n")
    f.write("Created by : #{Application::NAME}")
    f.write(" (version #{Application::VERSION})\n")
    f.write("File       : #{get(:logname)}\n")
    f.write("Time       : #{Time.new}\n")
    f.write("Author     : David Vargas\n")
    f.write('=' * 50 + "\n\n")

    verbose '[INFO] Project open'
    verbose '   ├── inputdirs    = ' + Rainbow(get(:inputdirs)).bright
    verbose '   └── process_file = ' + Rainbow(get(:process_file)).bright
  end

  def create_output_file
    # Create or reset output file
    @param[:outputfile] = File.open(get(:outputpath), 'w')
    f = get(:outputfile)
    f.write('// ' + ('=' * 50) + "\n")
    f.write("// Created by : #{Application::NAME}")
    f.write(" (version #{Application::VERSION})\n")
    f.write("// File       : #{get(:outputname)}\n")
    f.write("// Time       : #{Time.new}\n")
    f.write("// Author     : David Vargas\n")
    f.write('// ' + ('=' * 50) + "\n")
    f.write("\n")
    f.write("$CATEGORY: $course$/#{get(:category)}\n") if get(:category) != :none
  end

  def create_lesson_file
    # Create or reset lesson file
    @param[:lessonfile] = File.new(get(:lessonpath), 'w')
    f = get(:lessonfile)
    f.write('=' * 50 + "\n")
    f.write("Created by : #{Application::NAME}")
    f.write(" (version #{Application::VERSION})\n")
    f.write("File       : #{get(:lessonname)}\n")
    f.write("Time       : #{Time.new}\n")
    f.write("Author     : David Vargas\n")
    f.write('=' * 50 + "\n")
  end

  def create_yaml_file
    # Create or reset yaml file
    @param[:yamlfile] = File.open(get(:yamlpath), 'w')
  end
end
