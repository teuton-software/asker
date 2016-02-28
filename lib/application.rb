# encoding: utf-8
require 'singleton'

class Application
  include Singleton
  attr_reader :name, :version
  attr_accessor :param

  def initialize
    @name="darts-of-teacher"
    @version="0.6"
    @param={}
	@param[:inputbasedir]="input"
  end

  def fill_param_with_default_values
    @param[:process_file]=@param[:process_file] || "#{@param[:projectdir].split("/").last}.haml"
    process_filename_without_ext=@param[:process_file].split(".").first # Extract extension
    @param[:projectname]=@param[:projectname] || process_filename_without_ext
		
    @param[:inputdirs]=@param[:inputdirs] || "input/#{@param[:projectdir]}"
    @param[:outputdir]=@param[:outputdir] || "output" 
    @param[:outputname]=@param[:outputname] || "#{@param[:projectname]}-gift.txt"
    @param[:logname]=@param[:logname] || "#{@param[:projectname]}-log.txt"
    @param[:lesson_file]=@param[:lesson_file] || "#{@param[:projectname]}-doc.txt"
    @param[:lesson_separator]=@param[:lesson_separator] || ' >'

    @param[:category]=@param[:category] || :none
    @param[:formula_weights]=@param[:formula_weights] || [1,1,1]
    @param[:lang]= @param[:lang] || 'en'
    @param[:show_mode]=@param[:show_mode] || :default
    @param[:verbose]=@param[:verbose] || true
  end

  def method_missing(m, *args, &block)
    return @param[m]
  end  
end	

