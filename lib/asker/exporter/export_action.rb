require_relative "concept_ai_yaml_exporter"
require_relative "export2doc"
require_relative "export2gift"
require_relative "export2moodle_xml"

##
# Export Output data files
# * YAML, Doc (txt), Gift (ConceptAI, Code) and Moodle XML (ConceptAI, Code)
class ExportAction
  def call(data, project)
    output = Application.instance.config["output"]

    ConceptAIYAMLExporter.export_all(data[:concepts_ai], project) if output["yaml"] == "yes"
    Export2Doc.new.call(data, project) if output["doc"] == "yes"
    Export2Gift.new.call(data, project) if output["gift"] == "yes"
    Export2MoodleXML.new.call(data, project) if output["moodle"] == "yes"
  end
end
