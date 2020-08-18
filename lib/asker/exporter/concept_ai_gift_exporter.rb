# frozen_string_literal: true

require_relative '../project'
require_relative '../formatter/question_gift_formatter'

# Export ConceptIA data to gift to outputfile
module ConceptAIGiftExporter
  ##
  # Export an array of ConceptAI objects from Project into GIFT outpufile
  # @param concepts_ai (Array)
  # @param file (File)
  def self.export_all(concepts_ai, project)
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

    concepts_ai.each { |concept_ai| export(concept_ai, file) }

    file.close
  end

  ##
  # Export 1 concept_ai from project
  # @param concept_ai (ConceptAI)
  # @param file (File)
  # rubocop:disable Metrics/AbcSize
  private_class_method def self.export(concept_ai, file)
    return unless concept_ai.process?

    file.write head(concept_ai.name)
    Application.instance.config['questions']['stages'].each do |stage|
      concept_ai.questions[stage].each do |question|
        file.write(QuestionGiftFormatter.to_s(question))
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  ##
  # Convert Concept name into gift format head
  # @param name (String)
  # @return String
  private_class_method def self.head(name)
    s = "\n"
    s += '// ' + '=' * 50 + "\n"
    s += "// Concept name: #{name}\n"
    s += '// ' + '=' * 50 + "\n"
    s
  end
end
