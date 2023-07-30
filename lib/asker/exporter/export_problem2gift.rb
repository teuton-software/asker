require_relative "../formatter/question_gift_formatter"

class ExportProblem2Gift
  ##
  # Export an Array of problems to gift format file
  # @param problems (Array)
  def call(problems, file)
    problems.each { |problem| export_one(problem, file) }
  end

  private

  def export_one(problem, file)
    return false unless problem.process?

    file.write head(problem)
    problem.questions.each do |question|
      file.write QuestionGiftFormatter.to_s(question)
    end
    true
  end

  def head(problem)
    s = "\n"
    s += "// " + "=" * 50 + "\n"
    s += "// Problem: #{problem.name} (#{problem.questions.size} questions)\n"
    s += "// " + "=" * 50 + "\n"
    s
  end
end
