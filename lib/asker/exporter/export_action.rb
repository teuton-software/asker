require_relative "export2doc"
require_relative "export2gift"
require_relative "export2moodle_xml"
require_relative "export2yaml"

##
# Export Output data files
# * YAML, Doc (txt), Gift (ConceptAI, Code) and Moodle XML (ConceptAI, Code)
class ExportAction
  def call(data, project)
    output = Application.instance.config["output"]

    Export2Doc.new.call(data, project) if output["doc"] == "yes"
    Export2Gift.new.call(data, project) if output["gift"] == "yes"
    Export2MoodleXML.new.call(data, project) if output["moodle"] == "yes"
    Export2YAML.new.call(data[:concepts_ai], project) if output["yaml"] == "yes"
  end
end
