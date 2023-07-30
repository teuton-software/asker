require_relative "concept_ai_yaml_exporter"
require_relative "concept_doc_exporter"
require_relative "data_gift_exporter"
require_relative "data_moodle_exporter"

##
# Export Output data files
# * YAML, Doc (txt), Gift (ConceptAI, Code) and Moodle XML (ConceptAI, Code)
module OutputFileExporter
  def self.export(data, project)
    config = Application.instance.config
    ConceptAIYAMLExporter.export_all(data[:concepts_ai], project) if config["output"]["yaml"] == "yes"
    ConceptDocExporter.export_all(data[:concepts], project) if config["output"]["doc"] == "yes"
    DataGiftExporter.export_all(data, project) if config["output"]["gift"] == "yes"
    DataMoodleExporter.call(data, project) if config["output"]["moodle"] == "yes"
  end
end
