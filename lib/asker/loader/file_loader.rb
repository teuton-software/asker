require_relative "content_loader"
require_relative "haml_loader"

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
      msg = "[ERROR] FileLoader: Load HAML or XML file! (#{filename})"
      warn Rainbow(msg).red
      raise msg
    end
    ContentLoader.call(filename, file_content)
  end
end
