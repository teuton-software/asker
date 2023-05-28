class Problem
  attr_accessor :process
  attr_accessor :filename
  attr_accessor :varnames
  attr_accessor :cases
  attr_accessor :descs
  attr_accessor :questions
  attr_accessor :steps

  def initialize
    @process = false
    @filename = "?"
    @varnames = []
    @cases = []
    @descs = []
    @questions = []
    @steps = []
  end

  def self.from(values)
    problem = Problem.new
    fields = %i(filename varnames cases descs questions steps)
    fields.each do |fieldname|
      methodname = "#{fieldname}=".to_sym
      problem.send(methodname, values[fieldname])
    end
    problem
  end
end
