
require_relative '../formatter/question_moodle_formatter'

module ConceptAIMoodleExporter

  def self.run(concept_ai, file)
    return unless concept_ai.concept.process?

    Application.instance.config['questions']['stages'].each do |stage|
      concept_ai.questions[stage].each do |question|
        file.write(QuestionMoodleFormatter.to_s(question))
      end
    end
  end
end
