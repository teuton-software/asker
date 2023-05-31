
require_relative "../lang/lang_factory"
require_relative "question"

class ProblemAI
  attr_accessor :problem

  def call(problem)
    @problem = problem
    create_questions
    @problem
  end

  private

  def create_questions
    puts "_" * 40
    vars = problem.varnames
    problem.cases.each do |acase|
      vars.each_with_index do |varname, index|
        print "| #{varname} = #{acase[index]} "
      end
      puts ""
    end
  end
end
