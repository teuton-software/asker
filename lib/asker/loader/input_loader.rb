# frozen_string_literal: true

require_relative 'directory_loader'
require_relative '../logger'

# Load DATA defined by Project
# InputLoader     => DirectoryLoader
# DirectoryLoader => FileLoader
# FileLoader      => ContentLoader
# ContentLoader   => Concept and CodeLoader
module InputLoader
  ##
  # Load input data from every input directory
  # @param inputdirs (Array)
  def self.load(inputdirs)
    output = { concepts: [], codes: [] }
    Logger.verbose "\n[INFO] Loading input data"

    # inputdirs = project.inputdirs.split(',')
    inputdirs.each do |dirname|
      data = DirectoryLoader.load(dirname)
      output[:concepts] += data[:concepts]
      output[:codes] += data[:codes]
    end

    output
  end
end
