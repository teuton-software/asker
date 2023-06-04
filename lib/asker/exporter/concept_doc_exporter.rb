# frozen_string_literal: true

require_relative "../formatter/concept_doc_formatter"
require_relative "../version"

##
# Export Concept to Doc file
module ConceptDocExporter
  ##
  # Export array of concepts to doc
  def self.export_all(concepts, project)
    file = File.new(project.get(:lessonpath), "w")
    file.write("=" * 50 + "\n")
    file.write("Created by : #{Asker::NAME} (version #{Asker::VERSION})\n")
    file.write("File       : #{project.get(:lessonname)}\n")
    file.write("Time       : #{Time.new}\n")
    file.write("=" * 50 + "\n")

    concepts.each do |concept|
      file.write(ConceptDocFormatter.to_s(concept)) if concept.process
    end
    file.close
  end
end
