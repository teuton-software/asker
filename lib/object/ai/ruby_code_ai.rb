
require_relative '../ai/question'

class RubyCodeAI

  def initialize(data_object)
    @data_object = data_object
    @filename = data_object.filename
    @type = :rubycode
    @process = data_object.process
    @lines = data_object.lines
    @questions = []
    @output = '' #FIXME
  end

  def debug
    puts "[INFO] Output:"
    puts @output
  end

  def clone_array(array)
    out = []
    array.each { |item| out << item.dup }
    out
  end

  def make_questions_from_ai
    make_comment_error
    make_string_error
    make_keyword_error
  end

  def make_comment_error
    error_lines = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?('#')
    end
    error_lines.each do |index|
      lines = Utils.clone_array @lines
      lines[index].sub!('#','').strip!
      @output << "make comment error (line #{index})\n"
      lines.each_with_index { |line,index| @output << "[%2d] #{line}\n"%index }
    end
  end

  def make_string_error
    error_lines = []
    @lines.each_with_index do |line,index|
      error_lines << index if line.include?("'")
    end
    error_lines.each do |index|
      lines = Utils.clone_array @lines
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
      lines = Utils.clone_array @lines
      lines[index].sub!('end','edn')
      @output << "make keyword error (line #{index})\n"
      lines.each_with_index { |line,index| @output << "[%2d] #{line}\n"%index }
    end
  end
end
