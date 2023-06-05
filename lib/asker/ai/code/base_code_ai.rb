# frozen_string_literal: false

require_relative "../../lang/lang_factory"
require_relative "../../ai/question"

##
# BaseCodeAI class
class BaseCodeAI
  attr_reader :questions

  def initialize(code)
    @code = code
    @lines = code.lines
    @num = 0
    @questions = []
    make_questions
  end

  def name
    File.basename(@code.filename)
  end

  def process?
    @code.process?
  end

  def type
    @code.type
  end

  def filename
    @code.filename
  end

  def lines
    @code.lines
  end

  def num
    @num += 1
  end

  def clone_array(array)
    out = []
    array.each { |item| out << item.dup }
    out
  end

  def lines_to_s(lines)
    out = ""
    lines.each_with_index do |line, index|
      out << "%2d: #{line}\n" % (index + 1)
    end
    out
  end

  def lines_to_html(lines)
    out = ""
    lines.each_with_index do |line, index|
      out << "%2d: #{line}</br>" % (index + 1)
    end
    out
  end

  def make_questions
    list = find_make_methods
    list.each { |m| @questions += send m }
    @questions
  end

  private

  def find_make_methods
    list = public_methods.sort
    list.select! { |name| name.to_s.start_with? "make_" }
    list.delete(:make_questions)
    list
  end
end
