# frozen_string_literal: true

require_relative 'content_loader'
require_relative 'haml_loader'
require_relative '../logger'

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
      msg = "[ERROR] FileLoader: Format error #{filename}"
      Logger.verbose msg
      raise msg
    end
    ContentLoader.load(filename, file_content)
  end
end
