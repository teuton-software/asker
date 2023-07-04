require_relative "../../logger"
require_relative "customizer"

class StageBase
  def initialize(problem)
    @problem = problem
    @customs = get_customs(@problem)
    @customizer = Customizer.new(@problem)
    @counter = @problem.questions.size
  end

  def counter
    @counter += 1
  end

  def customize(...)
    @customizer.call(...)
  end
  
  private
  
  def get_customs(problem)
    return [] if problem.cases.nil?
    
    customs = []
    vars = problem.varnames
    problem.cases.each do |acase|
      custom = {}
      vars.each_with_index { |varname, index| custom[varname] = acase[index] }
      customs << custom
    end
    customs
  end  
end