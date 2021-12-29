# frozen_string_literal: true

require_relative 'content_loader'
require_relative 'haml_loader'

# Methods that load a filename and return list of concepts
module FileLoader
  ##
  # Load asker data from file
  # @param filename (String) File name to be load
  def self.load(filename)
    if File.extname(filename).casecmp('.haml').zero?
      file_content = HamlLoader.load filename
    elsif File.extname(filename).casecmp('.xml').zero?
      file_content = File.read(filename)
    else
      puts "[ERROR] FileLoader: Format error #{filename}"
      raise msg
    end
    ContentLoader.load(filename, file_content)
  end
end
