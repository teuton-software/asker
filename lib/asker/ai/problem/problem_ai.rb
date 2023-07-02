require_relative "../../lang/lang_factory"
require_relative "../question"
require_relative "stage_answers"
require_relative "stage_steps"

class ProblemAI
  attr_accessor :problem
  include StageAnswers
  include StageSteps

  def call(problem)
    @problem = problem
    @customs = get_customs(@problem)
    make_questions
    @problem
  end

  def make_questions
    @counter = 0
    a_questions = make_questions_with_answers
    s_questions = make_questions_with_steps

    @problem.stats[:answer] = a_questions.size
    @problem.stats[:steps] = s_questions.size
    @problem.questions = a_questions + s_questions
  end

  private

  def counter
    @counter += 1
  end

  def customize(text:, custom:, type: nil)
    output = text.clone
    custom.each_pair { |oldvalue, newvalue| output.gsub!(oldvalue, newvalue) }

    if type.nil?
      return output 
    elsif type == "formula"
      begin
        return eval(output).to_s
      rescue SyntaxError => e
        Logger.error "Problem.name = #{@problem.name}"
        Logger.error "ProblemAI: Wrong formula '#{text}' or wrong values '#{output}'"
        Logger.error e.to_s
        exit 1
      end
    else
      Logger.error "ProblemAI: Wrong answer type (#{type})"
      exit 1
    end
  end

  def get_customs(problem)
    customs = []
    vars = problem.varnames
    problem.cases.each do |acase|
      custom = {}
      vars.each_with_index { |varname, index| custom[varname] = acase[index] }
      customs << custom
    end
    customs
  end

  def lines_to_s(lines)
    output = ""
    lines.each_with_index do |line, index|
      output << "%2d: #{line}\n" % (index + 1)
    end
    output
  end
end
