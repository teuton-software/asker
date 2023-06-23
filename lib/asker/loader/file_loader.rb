require_relative "content_loader"
require_relative "haml_loader"
require_relative "../logger"

##
# Load a filename and return a Hash with concepts list and code list
# return { concepts: [], codes: [] }
module FileLoader
  def self.call(filename)
    if File.extname(filename).casecmp(".haml").zero?
      file_content = HamlLoader.load filename
    elsif File.extname(filename).casecmp(".xml").zero?
      file_content = File.read(filename)
    else
      Logger.error "FileLoader: HAML or XML required (#{filename})"
      exit 1
    end
    ContentLoader.new.call(filename, file_content)
  end
end
