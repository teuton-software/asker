require_relative '../formatter/question_moodle_formatter'

class ProblemMoodleExporter
  def call(problem, file)
    return false unless problem.process?

    problem.questions.each do |question|
      file.write QuestionMoodleFormatter.to_s(question)
    end
    true
  end
end
