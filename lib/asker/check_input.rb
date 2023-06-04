require_relative "check_input/check_haml_data"
require_relative "logger"

class CheckInput
  def check(filepath)
    @filepath = filepath
    # Check HAML file syntax
    exist = check_file_exist
    return false unless exist
    check_file_content
  end

  private

  def check_file_exist
    if @filepath.nil?
      Logger.error "CheckInput: Unkown filename"
      exit 1
    end
    unless File.exist? @filepath
      Logger.error "CheckInput: File not found! (#{@filepath})"
      exit 1
    end
    unless File.extname(@filepath) == ".haml"
      Logger.error "CheckInput: Check works with HAML files!"
      exit 1
    end
    true
  end

  def check_file_content
    data = CheckHamlData.new(@filepath)
    data.check
    data.show_errors if @verbose
    data.ok?
  end
end
