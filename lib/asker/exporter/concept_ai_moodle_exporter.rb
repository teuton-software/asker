# frozen_string_literal: true

# Export ConceptIA data to gift to moodlefile
module ConceptAIMoodleExporter
  ##
  # Export an array of ConceptAI objects from Project into GIFT outpufile
  # @param concepts_ai (Array)
  # @param file (File)
  def self.export_all(concepts_ai, project)
    file = File.open(project.get(:moodlepath), 'w')
    file.write('Moodle XML file')
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
        file.write("QuestionMoodleFormatter.to_s(#{question.name})")
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
