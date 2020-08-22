# frozen_string_literal: true

require_relative '../formatter/concept_doc_formatter'

##
# Export Concept to Doc file
module ConceptDocExporter
  ##
  # Export arrya of concepts to doc
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def self.export_all(concepts, project)
    file = File.new(project.get(:lessonpath), 'w')
    file.write('=' * 50 + "\n")
    file.write("Created by : #{Application::NAME} (version #{Application::VERSION})\n")
    file.write("File       : #{project.get(:lessonname)}\n")
    file.write("Time       : #{Time.new}\n")
    file.write("Author     : David Vargas Ruiz\n")
    file.write('=' * 50 + "\n")

    concepts.each do |concept|
      file.write(ConceptDocFormatter.to_s(concept)) if concept.process
    end
    file.close
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
