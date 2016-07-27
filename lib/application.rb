# encoding: utf-8
require 'singleton'

class Application
  include Singleton
  attr_reader :name, :version
  attr_accessor :param

  def initialize
    @name="darts-of-teacher"
    @version="0.9.0"

    @param={}
    @param[:inputbasedir]    = "input"
    @param[:outputdir]       = "output"
    @param[:category]        = :none
    @param[:formula_weights] = [1,1,1]
    @param[:lang]            = 'en'
    @param[:show_mode]       = :default
    @param[:verbose]         = true
  end

  def fill_param_with_values
    #We need at least process_file and inputdirs params
    ext = ".haml"

    @param[:process_file] = @param[:process_file] || @param[:projectdir].split(File::SEPARATOR).last + ext
    @param[:projectname]  = @param[:projectname] || File.basename( @param[:process_file], ext)
    @param[:inputdirs]=@param[:inputdirs] || "input/#{@param[:projectdir]}"
    @param[:outputname]=@param[:outputname] || "#{@param[:projectname]}-gift.txt"
    @param[:logname]=@param[:logname] || "#{@param[:projectname]}-log.txt"
    @param[:lesson_file]=@param[:lesson_file] || "#{@param[:projectname]}-doc.txt"
  end

  def method_missing(m, *args, &block)
    return @param[m]
  end
end
