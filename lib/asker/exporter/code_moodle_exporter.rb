
require_relative '../formatter/question_moodle_formatter'

module CodeMoodleExporter

  def self.run(code, file)
    return false unless code.process?

    code.questions.each do |question|
      file.write QuestionMoodleFormatter.to_s(question)
    end
    true
  end

end
