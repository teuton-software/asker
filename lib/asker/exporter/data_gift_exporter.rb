# frozen_string_literal: true

require_relative 'concept_ai_gift_exporter'
require_relative 'code_gift_exporter'

# Export Data (ConceptIA and Code) to gift to outputfile
module DataGiftExporter
  ##
  # Export an array of Data (ConceptAI and Code objects) into GIFT outpufile
  # @param data (Hash)
  # @param project (Project)
  def self.export_all(data, project)
    file = File.open(project.get(:outputpath), 'w')
    file.write('// ' + ('=' * 50) + "\n")
    file.write("// Created by : #{Application::NAME}")
    file.write(" (version #{Application::VERSION})\n")
    file.write("// File       : #{project.get(:outputname)}\n")
    file.write("// Time       : #{Time.new}\n")
    file.write("// Author     : David Vargas Ruiz\n")
    file.write('// ' + ('=' * 50) + "\n\n")
    category = Application.instance.config['questions']['category']
    file.write("$CATEGORY: $course$/#{category}\n") unless category.nil?

    ConceptAIGiftExporter.export_all(data[:concepts_ai], file)
    CodeGiftExporter.export_all(data[:codes_ai], file)

    file.close
  end
end
