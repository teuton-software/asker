require_relative 'ai/code_ai_factory'
require_relative '../project'
require_relative '../formatter/code_string_formatter'

class Code
  attr_reader :filename, :type
  attr_accessor :description, :process
  attr_reader :lines, :questions

  def initialize(filename,type)
    @filename = filename # path to code file
    @type = type
    @process = true
    @lines = load(@filename)
    @questions = []
    @code_ai = CodeAIFactory.get(self)
  end

  def process?
    @process
  end

  def make_questions
    return unless process?
    @questions += @code_ai.make_questions
  end

  def lines_to_s(lines)
    out = ''
    lines.each_with_index do |line,index|
        out << format("%2d| #{line}\n", (index + 1))
    end
    out
  end

  def debug
    out = CodeStringFormatter.to_s(self)
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
