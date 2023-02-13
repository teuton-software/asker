# frozen_string_literal: true

require_relative 'file_loader'

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
    DirectoryLoader.load_files(accepted, dirname)
  end

  ##
  # Check directory
  # @param dirname (String) Directory name
  def self.check_dir(dirname)
    return if Dir.exist? dirname

    msg = Rainbow("[ERROR] #{dirname} directory dosn't exist!").color(:red)
    puts msg
    raise msg
  end

  ##
  # Load files from dirname directory
  # @param filenames (Array) File name list
  # @param dirname (String) Base directory
  def self.load_files(filenames, dirname)
    output = { concepts: [], codes: [] }
    filenames.each do |filename|
      filepath = File.join(dirname, filename)
      data = FileLoader.load(filepath)
      output[:concepts] += data[:concepts]
      output[:codes] += data[:codes]
    end
    output
  end
end
