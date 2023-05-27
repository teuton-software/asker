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

  class Step
    attr_accessor :text
    attr_accessor :formula
    attr_accessor :varname
    attr_accessor :feedback

    def initialize(varnames)
      @varnames = varnames
      @text = ""
      @formula = ""
      @varname = ""
    end
  end
end
