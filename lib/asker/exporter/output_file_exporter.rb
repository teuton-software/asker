require_relative 'concept_ai_moodle_exporter'
require_relative 'concept_ai_yaml_exporter'
require_relative 'concept_doc_exporter'
require_relative 'data_gift_exporter'

# Export Output data:
# * Gift (ConceptAI, Code)
# * YAML
# * Doc (txt)
module OutputFileExporter
  def self.export(data, project)
    config = Application.instance.config
    DataGiftExporter.export_all(data, project) if config['output']['gift'] == 'yes'
    ConceptAIYAMLExporter.export_all(data[:concepts_ai], project) if config['output']['yaml'] == 'yes'
    ConceptDocExporter.export_all(data[:concepts], project) if config['output']['doc'] == 'yes'
    # ConceptAIGiftExporter.export_all(data[:concepts_ai], project) if config['output']['gift'] == 'yes'
    # CodeGiftExporter.export_all(data[:codes_ai], project.get(:outputfile)) if config['output']['gift'] == 'yes'
    # UNDER DEVELOPMENT
    ConceptAIMoodleExporter.export_all(data[:concepts_ai], project) if config['output']['moodle'] == 'yes'
  end
end
