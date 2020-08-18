# frozen_string_literal: true

require_relative '../formatter/question_moodle_formatter'

# Export ConceptIA data to gift to moodlefile
module ConceptAIMoodleExporter
  ##
  # Export an array of ConceptAI objects from Project into GIFT outpufile
  # @param concepts_ai (Array)
  # @param file (File)
  def self.export_all(concepts_ai, project)
    file = File.open(project.get(:moodlepath), 'w')
    file.write("Moodle XML file\n")

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

    Application.instance.config['questions']['stages'].each do |stage|
      concept_ai.questions[stage].each do |question|
        file.write(QuestionMoodleFormatter.to_s(question))
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
