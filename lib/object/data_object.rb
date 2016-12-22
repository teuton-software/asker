require_relative 'object_ai_factory'

class DataObject
  attr_reader :filename, :type
  attr_accessor :description, :process
  attr_reader :lines

  def initialize(filename,type)
    @filename = filename
    @type = type
    @process = true
    @lines = load(@filename)
    @questions = []
    @object_ai = ObjectAIFactory.get(self)
  end

  def load(filename)
    return if filename.nil?
    content = File.read(filename)
    content.split("\n")
  end

  def make_questions
    @object_ai.make_questions
  end

  def debug
    puts "[INFO] Params:"
    puts "  * filename : #{@filename}"
    puts "  * lines    : #{@lines.size}"
    puts "\n"
    puts "[INFO] Source code:"
    @lines.each_with_index do |line,index|
      puts "[%2d] #{line}"%index
    end
    @object_ai.debug
  end
end
