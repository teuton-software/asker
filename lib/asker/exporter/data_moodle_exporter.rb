
require_relative '../version'
require_relative 'concept_ai_moodle_exporter'
require_relative 'code_moodle_exporter'

# Export data to MoodleXML file
module DataMoodleExporter

  def self.export_all(data, project)
    file = File.open(project.get(:moodlepath), 'w')
    file.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
    file.write("<quiz>\n")
    file.write("<!--\n#{('=' * 50)}\n")
    file.write(" Created by : #{Asker::NAME}")
    file.write(" (version #{Asker::VERSION})\n")
    file.write(" File       : #{project.get(:moodlename)}\n")
    file.write(" Time       : #{Time.new}\n")
    file.write("#{('=' * 50)}\n-->\n\n")

    data[:concepts_ai].each do |concept_ai|
      ConceptAIMoodleExporter.run(concept_ai, file)
    end

    data[:codes_ai].each do |code|
      CodeMoodleExporter.run(code, file)
    end

    file.write("</quiz>\n")
    file.close
  end
end
