# frozen_string_literal: true

require_relative 'directory_loader'

# Load DATA defined by Project
# InputLoader     => DirectoryLoader
# DirectoryLoader => FileLoader
# FileLoader      => ContentLoader
# ContentLoader   => Concept and CodeLoader
module InputLoader
  def self.load
    output = { concepts: [], codes: [] }
    project = Project.instance
    project.verbose "\n[INFO] Loading input data"

    inputdirs = project.inputdirs.split(',')
    inputdirs.each do |dirname|
      data = DirectoryLoader.load(dirname)
      output[:concepts] += data[:concepts]
      output[:codes] += data[:codes]
    end

    output
  end
end
