# frozen_string_literal: true

require_relative 'file_loader'
require_relative '../logger'

# Load input data from one directory
module DirectoryLoader
  ##
  # Load input data from directory
  # @param dirname (String) Directory name
  def self.load(dirname)
    DirectoryLoader.check_dir(dirname)
    files = (Dir.new(dirname).entries - ['.', '..']).sort
    # Accept only HAML or XML files
    accepted = files.select { |f| %w[.xml .haml].include? File.extname(f) }
    Logger.verbose " * Input directory  = #{Rainbow(dirname).bright}"
    DirectoryLoader.load_files(accepted, dirname)
  end

  ##
  # Check directory
  # @param dirname (String) Directory name
  def self.check_dir(dirname)
    return if Dir.exist? dirname

    msg = Rainbow("[ERROR] #{dirname} directory dosn't exist!").color(:red)
    Logger.verboseln msg
    raise msg
  end

  ##
  # Load accepted files from dirname directory
  # @param filenames (Array) File name list
  # @param dirname (String) Base directory
  def self.load_files(filenames, dirname)
    output = { concepts: [], codes: [] }
    filenames.each do |filename|
      filepath = File.join(dirname, filename)
      data = DirectoryLoader.load_file(filepath, filename == filenames.last)
      output[:concepts] += data[:concepts]
      output[:codes] += data[:codes]
    end
    output
  end

  ##
  # Load one input file
  # @param filepath (String) Path to input file
  # @param last (Boolean) True if it is the last filename
  def self.load_file(filepath, last = false)
    if last
      Logger.verbose "   └── Input file   = #{Rainbow(filepath).bright}"
    else
      Logger.verbose "   ├── Input file   = #{Rainbow(filepath).bright}"
    end
    FileLoader.load(filepath)
  end
end
