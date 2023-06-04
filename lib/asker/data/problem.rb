require_relative "../logger"

class Problem
  attr_accessor :lang
  attr_accessor :context
  attr_accessor :process
  attr_accessor :filename
  attr_accessor :varnames
  attr_accessor :cases
  attr_accessor :descs
  attr_accessor :asks
  attr_accessor :questions

  @@id = 0
  def initialize
    @@id +=1
    @id = @@id
    @lang = nil
    @context = nil
    @process = false
    @filename = "?"
    @varnames = []
    @cases = []
    @descs = []
    @asks = []
    @questions = []
  end

  def self.from(values)
    problem = Problem.new
    fields = %i(filename varnames cases descs asks)
    fields.each do |fieldname|
      methodname = "#{fieldname}=".to_sym
      problem.send(methodname, values[fieldname])
    end
    problem.validate
    problem
  end

  def desc
    @descs.first
  end

  def process?
    @process
  end

  def name
    "problem#{@id}"
  end

  def validate
    validate_varnames
    validate_cases
    validate_asks
  end

  private

  def validate_varnames
    if !@varnames.size.zero? && @cases.size.zero?
      Logger.warn "Problem: No problem/varnames defined with no problem/case"
    end
  end

  def validate_cases
    @cases.each do |acase|
      if acase.size != @varnames.size
        Logger.error "Problem: problem/cases size not equal to problem/varnames size"
        Logger.error "       : cases size #{acase.size} (#{acase.join(",")})"
        Logger.error "       : varnames size #{@varnames.size} (#{@varnames.join(",")})"
        exit 1
      end
    end
  end

  def validate_asks
    if @asks.size.zero?
      Logger.warn "Problem: No problem/ask"
    end

    @asks.each do |ask|
      Logger.warn "Problem: No problem/ask/text" if ask[:text].nil?
      if ask[:answer].nil? && ask[:steps].size.zero?
        Logger.error "Problem: No problem/ask/answer or problem/ask/step"
        exit 1
      end
    end
  end
end
