require_relative "check_input/check_haml_data"
require_relative "logger"

class CheckInput
  attr_accessor :verbose

  def initialize
    @verbose = true
  end

  def check(filepath)
    # Check HAML file syntax
    exist = check_file_exist(filepath)
    return false unless exist
    check_file_content(filepath)
  end

  private

  def check_file_exist(filepath)
    if filepath.nil?
      Logger.error "CheckInput: Unknown filename"
      exit 1
    end
    unless File.exist? filepath
      Logger.error "CheckInput: File not found! (#{filepath})"
      exit 1
    end
    unless File.extname(filepath) == ".haml"
      Logger.error "CheckInput: Check works with HAML files!"
      exit 1
    end
    true
  end

  def check_file_content(filepath)
    data = CheckHamlData.new(filepath)
    data.check
    data.show_errors if @verbose
    data.ok?
  end
end
