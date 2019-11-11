require_relative 'ai/code_ai_factory'
require_relative '../project'
require_relative '../formatter/code_string_formatter'

# Contains code data input
class Code
  attr_reader :dirname, :filename, :type
  attr_accessor :process, :features
  attr_reader :lines, :questions

  def initialize(dirname, filename, type)
    @dirname = dirname
    @filename = filename
    @type = type
    @filepath = File.join(@dirname, @filename)
    @process = false
    @features = []
    @lines = load(@filepath)
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
    lines.each_with_index do |line, index|
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

  def load(filepath)
    return if filepath.nil?
    content = File.read(filepath)
    content.split("\n")
  end
end
