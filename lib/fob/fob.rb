require_relative 'ai/fob_ai_factory'
require_relative '../project'
require_relative '../formatter/fob_string_formatter'

class FOB
  attr_reader :filename, :type
  attr_accessor :description, :process
  attr_reader :lines, :questions

  def initialize(filename,type)
    @filename = filename
    @type = type
    @process = true
    @lines = load(@filename)
    @questions = []
    @fob_ai = FOBAIFactory.get(self)
  end

  def process?
    @process
  end

  def make_questions
    @questions += @fob_ai.make_questions
  end

  def lines_to_s(lines)
    out = ''
    lines.each_with_index do |line,index|
        out << format("%2d| #{line}\n", (index + 1))
    end
    out
  end

  def debug
    out = FOBStringFormatter.to_s(self)
    p = Project.instance
    p.verbose out
  end

  private

  def load(filename)
    return if filename.nil?
    content = File.read(filename)
    content.split("\n")
  end
end
