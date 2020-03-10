
require_relative '../../lang/lang_factory'
require_relative '../../ai/question'
require_relative 'base_code_ai'

class SQLCodeAI < BaseCodeAI
  def initialize(code)
    @lang = LangFactory.instance.get('sql')
    super code
  end

  def make_comment_error
    error_lines = []
    questions = []
    @lines.each_with_index do |line,index|
      if line.include?('//')
        lines = clone_array @lines
        lines[index].sub!('//','').strip!

        q = Question.new(:short)
        q.name = "#{name}-#{num}-code1uncomment"
        q.text = @lang.text_for(:code1,lines_to_html(lines))
        q.shorts << (index+1)
        q.feedback = 'Comment symbol removed'
        questions << q
      elsif line.strip.size>0
        lines = clone_array @lines
        lines[index]='// ' + lines[index]

        q = Question.new(:short)
        q.name = "#{name}-#{num}-code1comment"
        q.text = @lang.text_for(:code1,lines_to_html(lines))
        q.shorts << (index+1)
        q.feedback = 'Comment symbol added'
        questions << q
      end
    end
    questions
  end

  def make_keyword_error
    error_lines = []
    questions = []

    @lang.mistakes.each_pair do |key,values|
      v = values.split(',')
      v.each do |value|
        @lines.each_with_index do |line,index|
          error_lines << index if line.include?(key.to_s)
        end

        error_lines.each do |index|
          lines = clone_array @lines
          lines[index].sub!(key.to_s, value)
          q = Question.new(:short)
          q.name = "#{name}-#{num}-code1keyword"
          q.text = @lang.text_for(:code1,lines_to_html(lines))
          q.shorts << (index+1)
          q.feedback = "Keyword error: '#{value}' must be '#{key}'"
          questions << q
        end
      end
    end
    questions
  end
end
