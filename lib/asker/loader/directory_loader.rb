# frozen_string_literal: true

require_relative "file_loader"
require_relative "../logger"

module DirectoryLoader
  ##
  # Load input data from one directory
  # @param dirname (String) Directory name
  def self.call(dirname)
    DirectoryLoader.check_dir(dirname)
    files = (Dir.new(dirname).entries - [".", ".."]).sort
    # Accept only HAML or XML files
    accepted = files.select { |f| %w[.xml .haml].include? File.extname(f) }
    DirectoryLoader.load_files(accepted, dirname)
  end

  def self.check_dir(dirname)
    return if Dir.exist? dirname

    Logger.error "DirectoryLoader: #{dirname} directory dosn't exist!"
    exit 1
  end

  ##
  # Load files from dirname directory
  # @param filenames (Array) File name list
  # @param dirname (String) Base directory
  def self.load_files(filenames, dirname)
    data = {concepts: [], codes: [], problems: []}
    filenames.each do |filename|
      filepath = File.join(dirname, filename)
      loaded = FileLoader.call(filepath)
      data[:concepts] += loaded[:concepts]
      data[:codes] += loaded[:codes]
      data[:problems] += loaded[:problems]
    end
    data
  end
end
