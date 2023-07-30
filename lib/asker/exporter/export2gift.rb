# frozen_string_literal: true

require_relative "gift/export_code2gift"
require_relative "gift/export_concept2gift"
require_relative "gift/export_problem2gift"
require_relative "../application"
require_relative "../version"

class Export2Gift
  ##
  # Export an array of Data (ConceptAIs, Codes and Problems objects) into GIFT file
  # @param data (Hash)
  # @param project (Project)
  def call(data, project)
    file = File.open(project.get(:outputpath), "w")
    file.write("// " + ("=" * 50) + "\n")
    file.write("// #{Asker::NAME}    : version #{Asker::VERSION}\n")
    file.write("// Filename : #{project.get(:outputname)}\n")
    file.write("// Datetime : #{Time.new}\n")
    file.write("// " + ("=" * 50) + "\n\n")
    category = Application.instance.config["questions"]["category"]
    file.write("$CATEGORY: $course$/#{category}\n") unless category.nil?

    ExportConcept2Gift.new.call(data[:concepts_ai], file)
    ExportCode2Gift.new.call(data[:codes_ai], file)
    ExportProblem2Gift.new.call(data[:problems], file)
    file.close
  end
end
