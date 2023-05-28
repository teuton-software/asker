class Problem
  attr_accessor :process
  attr_accessor :filename
  attr_accessor :varnames
  attr_accessor :cases
  attr_accessor :descs
  attr_accessor :asks
  attr_accessor :questions

  def initialize
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

  def validate
    @cases.each do |acase|
      if acase.size != @varnames.size
        puts "[ERROR] problem/varnames.size not equal to problem/cases/size"
        puts "        varnames size #{@varnames.size} (#{@varnames.join(",")})"
        puts "           cases size #{acase.size} (#{acase.join(",")})"
      end
    end

    if !@varnames.size.zero? && @cases.size.zero?
      puts "[ERROR] No problem/case"
    end

    if @asks.size.zero?
      puts "[ERROR] No problem/ask"
    end

    @asks.each do |ask|
      puts "[ERROR] No problem/ask/text" if ask[:text].nil?
      if ask[:answer].nil? && ask[:steps].size.zero?
        puts "[ERROR] No problem/ask/answer or problem/ask/step"
      end
    end
  end
end
