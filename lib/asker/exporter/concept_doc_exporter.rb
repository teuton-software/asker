# frozen_string_literal: true

require_relative '../project'
require_relative '../formatter/concept_doc_formatter'

##
# Export Concept to Doc file
module ConceptDocExporter
  ##
  # Export arrya of concepts to doc
  def self.export_all(concepts)
    file = Project.instance.lessonfile
    concepts.each do |concept|
      file.write(ConceptDocFormatter.to_s(concept)) if concept.process
    end
  end
end
