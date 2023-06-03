
require_relative "../../lang/lang_factory"
require_relative "../question"

class ProblemAI
  attr_accessor :problem

  def call(problem)
    @problem = problem
    @instances = create_instance
    @problem
  end

  private

  def create_instance
    instances = []
    vars = problem.varnames
    problem.cases.each do |acase|
      instance = {}
      vars.each_with_index { |varname, index| instance[varname] = acase[index] }
      instances << instance
    end

    puts problem.name
    pp instances

    instances.each do |instance|
      puts customize(problem.desc, instance)
      puts customize(problem.asks[0][:text], instance)
    end
    instances
  end

  def customize(text, instance)
    output = text.clone
    instance.each_pair { |oldvalue, newvalue| output.gsub!(oldvalue, newvalue) }
    output
  end
end
