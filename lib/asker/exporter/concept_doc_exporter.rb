# encoding: utf-8

require_relative '../project'
require_relative '../formatter/concept_doc_formatter'

class ConceptDocExporter

  def initialize(concepts)
    @concepts = concepts
  end

  def export
    file = Project.instance.lessonfile
    @concepts.each do |concept|
      if concept.process
        file.write(ConceptDocFormatter.new(concept).to_s)
      end
    end
  end

end
