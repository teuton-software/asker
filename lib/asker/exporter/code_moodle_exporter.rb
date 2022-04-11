
require_relative '../formatter/question_moodle_formatter'

module CodeMoodleExporter

  def self.run(codes, file)
    codes.each { |code| export(code, file) }
  end

  def self.export(code, file)
    return false unless code.process?

    file.write head(code)
    code.questions.each do |question|
      file.write QuestionMoodleFormatter.to_s(question)
    end
    true
  end

end
