
require_relative 'code'
require_relative '../formatter/question_gift_formatter'

class DemoLoader
  def initialize(dirname, files, type)
    @dirname = dirname
    @files = files
    @type = type
    @questions = {}
  end

  def load
    @files.each do |filename|
      filepath = File.join(@dirname, filename)
      data = Code.new(@dirname, filename, @type)
      data.process = true
      @questions[filepath] = data.make_questions
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
