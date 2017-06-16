require_relative 'ai/fob_ai_factory'
require_relative '../project'

class FOB
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

  def process?
    @process
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
    p = Project.instance
    p.verbose '[INFO] Params:'
    p.verbose "  * filename : #{@filename}"
    p.verbose "  * type     : #{@type}"
    p.verbose "  * lines    : #{@lines.size}"
    p.verbose "\n"
    p.verbose "[INFO] Source code:"
    p.verbose lines_to_s(@lines)
    p.verbose "[INFO] Questions:"
    p.verbose @questions.size
  end

  private

  def load(filename)
    return if filename.nil?
    content = File.read(filename)
    content.split("\n")
  end
end
