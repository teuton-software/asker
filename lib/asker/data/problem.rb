require_relative "../logger"
require_relative "../lang/lang_factory"

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
  attr_accessor :stats

  @@id = 0
  def initialize
    @@id += 1
    @id = @@id
    @lang = LangFactory.instance.get("en")
    @context = nil
    @process = false
    @filename = "?"
    @varnames = []
    @cases = []
    @descs = []
    @asks = []
    @questions = []
    @stats = { answer: 0, steps: 0}
  end

  def self.from(values)
    problem = Problem.new
    fields = %i[filename varnames cases descs asks]
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
    firstword = @descs[0]&.strip&.split(" ")&.first&.downcase || "problem"
    "#{firstword}#{@id}"
  end

  def validate
    validate_varnames
    validate_cases
    validate_asks
    validate_descs
  end

  private

  def validate_varnames
    return if @varnames.nil?

    if !@varnames.size.zero? && @cases.size.zero?
      Logger.warn "Problem: No problem/varnames defined with no problem/case"
    end

    @varnames.each_with_index do |varname1, index1|
      @varnames.each_with_index do |varname2, index2|
        next if index1 == index2
        if varname1.include? varname2
          Logger.error "Problem: varname(#{varname1}) includes varname(#{varname2}). Change one of them!"
          exit 1
        end
      end
    end
  end

  def validate_cases
    return if @cases.nil?
    
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
        Logger.error "Problem: No problem/ask/answer and no problem/ask/steps"
        exit 1
      end
      if !ask[:answer].nil? && !ask[:steps].size.zero?
        Logger.error "Problem: Choose problem/ask/answer or problem/ask/steps"
        exit 1
      end
      if ask[:steps].size > 0 && ask[:steps].size < 4
        Logger.warn "Problem: problem/ask/steps less than 4"
      end
    end
  end

  def validate_descs
    # require "debug"; binding.break
  end
end
