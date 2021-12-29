# frozen_string_literal: true

require 'singleton'

class ProjectData
  include Singleton
  attr_reader :default, :param

  def initialize
    reset
  end

  def reset
    @default = { inputbasedir: FileUtils.pwd,
                 stages: { d: true, b: true, f: true, i: true, s: true, t: true },
                 threshold: 0.5,
                 outputdir: 'output' }
    @param = {}
  end

  def get(key)
    return @param[key] unless @param[key].nil?

    @default[key]
  end

  def set(key, value)
    @param[key] = value
  end

  ##
  # Open new project
  # * setting new params and
  # * creating output files
  # IMPORTANT: We need at least these values
  # * process_file
  # * inputdirs
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def open
    ext = File.extname(@param[:process_file]) || '.haml'
    @param[:projectname] = @param[:projectname] ||
                           File.basename(@param[:process_file], ext)

    @param[:logname] = "#{@param[:projectname]}-log.txt"
    @param[:outputname] = "#{@param[:projectname]}-gift.txt"
    @param[:lessonname] = "#{@param[:projectname]}-doc.txt"
    @param[:yamlname] = "#{@param[:projectname]}.yaml"
    @param[:moodlename] = "#{@param[:projectname]}-moodle.xml"

    outputdir = get(:outputdir)
    @param[:logpath] = File.join(outputdir, get(:logname))
    @param[:outputpath] = File.join(outputdir, get(:outputname))
    @param[:lessonpath] = File.join(outputdir, get(:lessonname))
    @param[:yamlpath] = File.join(outputdir, get(:yamlname))
    @param[:moodlepath] = File.join(outputdir, get(:moodlename))

    Dir.mkdir(outputdir) unless Dir.exist?(outputdir)
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end
