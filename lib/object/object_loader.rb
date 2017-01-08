
require_relative 'data_object'
require_relative '../formatter/question_gift_formatter'

class ObjectLoader
  def initialize(dirbase, files, type)
    @files = files
    @dirbase = dirbase
    @type = type
    @questions = {}
  end

  def load
    @files.each do |filename|
      filepath = File.join(@dirbase, filename)
      data = DataObject.new(filepath, @type)
      @questions[filename] = data.make_questions
    end
  end

  def show
    t = 0
    puts '//' + '=' * 80
    puts "// type: #{@type}"
    @questions.each_pair do |k, v|
      puts "// * #{k}: #{v.size}"
      t += v.size
    end
    puts "// TOTAL = #{t}"
    puts '//' + '=' * 80

    @questions.each_value do |values|
      values.each { |question| puts QuestionGiftFormatter.new(question).to_s }
    end
  end
end
