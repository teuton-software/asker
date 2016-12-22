
require_relative '../../lang/lang_factory'
require_relative '../../ai/question'

class RubyCodeAI
  def initialize(data_object)
    @data_object = data_object
    @lines = data_object.lines
    @lang = LangFactory.instance.get('es')
    @num = 0
    @questions = []
    @output = '' #FIXME
  end

  def name
    @data_object.filename
  end

  def num
    @num+=1
  end

  def clone_array(array)
    out = []
    array.each { |item| out << item.dup }
    out
  end

  def lines_to_s(lines)
    out = ''
    lines.each_with_index do |line,index|
        out << "[%2d] #{line}\n"%(index+1)
    end
  end

  def make_questions
    @questions += make_comment_error
    make_string_error
    make_keyword_error
  end

  def make_comment_error
    error_lines = []
    questions = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?('#')
    end

    error_lines.each do |index|
      lines = clone_array @lines
      lines[index].sub!('#','').strip!

      q = Question.new(:short)
      q.name = "#{name}-#{num}-code1comment"
      q.text = @lang.text_for(:code1,lines_to_s(lines))
      q.good = (index+1)
      questions << q
    end
    questions
  end

  def make_string_error
    error_lines = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?("'")
    end
    error_lines.each do |index|
      lines = clone_array @lines
      lines[index].sub!("'",'')
      @output << "make string error (line #{index})\n"
      lines.each_with_index { |line,index| @output << "[%2d] #{line}\n"%index }
    end
  end

  def make_keyword_error
    error_lines = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?("end")
    end
    error_lines.each do |index|
      lines = clone_array @lines
      lines[index].sub!('end','edn')
      @output << "make keyword error (line #{index})\n"
      lines.each_with_index { |line,index| @output << "[%2d] #{line}\n"%index }
    end
  end
end
