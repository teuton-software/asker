require_relative 'concept_ai_gift_exporter'
require_relative 'code_gift_exporter'
require_relative 'concept_ai_yaml_exporter'
require_relative 'concept_doc_exporter'

# Export Output data:
# * Gift (ConceptAI, Code)
# * YAML
# * Doc (txt)
module OutputFileExporter
  def self.export(data, project)
    ConceptAIGiftExporter.export_all(data[:concepts_ai], project)
    # UNDER DEVELOPMENT
    CodeGiftExporter.export_all(data[:codes_ai], project.get(:outputfile))
    ConceptAIYAMLExporter.export_all(data[:concepts_ai], project)
    ConceptDocExporter.export_all(data[:concepts], project.get(:lessonfile))
  end
end
