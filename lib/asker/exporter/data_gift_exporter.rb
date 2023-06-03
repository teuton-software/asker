# frozen_string_literal: true

require_relative "concept_ai_gift_exporter"
require_relative "code_gift_exporter"
require_relative "problem_gift_exporter"
require_relative "../application"
require_relative "../version"

module DataGiftExporter
  ##
  # Export an array of Data (ConceptAIs, Codes and Problems objects) into GIFT file
  # @param data (Hash)
  # @param project (Project)
  def self.export_all(data, project)
    file = File.open(project.get(:outputpath), 'w')
    file.write('// ' + ('=' * 50) + "\n")
    file.write("// #{Asker::NAME}    : version #{Asker::VERSION}\n")
    file.write("// Filename : #{project.get(:outputname)}\n")
    file.write("// Datetime : #{Time.new}\n")
    file.write('// ' + ('=' * 50) + "\n\n")
    category = Application.instance.config['questions']['category']
    file.write("$CATEGORY: $course$/#{category}\n") unless category.nil?

    ConceptAIGiftExporter.export_all(data[:concepts_ai], file)
    CodeGiftExporter.export_all(data[:codes_ai], file)
    ProblemGiftExporter.new.call(data[:problems], file)
    file.close
  end
end
