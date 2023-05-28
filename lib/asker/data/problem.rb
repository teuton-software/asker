class Problem
  attr_accessor :varnames
  attr_accessor :cases
  attr_accessor :description
  attr_accessor :steps

  def initialize
    @varnames = []
    @cases = []
    @description = ""
    @steps = []
  end

  def self.from(values)
    problem = Problem.new
    fields = %i(varnames cases desc questions steps)
    fields.each do |fieldname|
      methodname = "#{fieldname}=".to_sym
      problem.send(methodname, values[fieldname])
    end
    problem
  end
end
