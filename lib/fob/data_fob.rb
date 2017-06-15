require_relative 'ai/fob_ai_factory'

class DataFOB
  attr_reader :filename, :type
  attr_accessor :description, :process
  attr_reader :lines

  def initialize(filename,type)
    @filename = filename
    @type = type
    @process = true
    @lines = load(@filename)
    @questions = []
    @object_ai = FOBAIFactory.get(self)
  end

  def make_questions
    @questions += @object_ai.make_questions
  end

  def lines_to_s(lines)
    out = ''
    lines.each_with_index do |line,index|
        out << format("%2d| #{line}\n", (index + 1))
    end
    out
  end

  def debug
    puts "[INFO] Params:"
    puts "  * filename : #{@filename}"
    puts "  * lines    : #{@lines.size}"
    puts "\n"
    puts "[INFO] Source code:"
    puts lines_to_s(@lines)
    puts "[INFO] Questions:"
    puts @questions.size
  end

  private

  def load(filename)
    return if filename.nil?
    content = File.read(filename)
    content.split("\n")
  end
end
