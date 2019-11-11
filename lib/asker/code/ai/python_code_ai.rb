
require_relative '../../lang/lang_factory'
require_relative '../../ai/question'
require_relative 'base_code_ai'

class PythonCodeAI < BaseCodeAI
  def initialize(data_object)
    @data_object = data_object
    @lines = data_object.lines
    @lang = LangFactory.instance.get('python')
    @num = 0
    @questions = []
  end

  def make_comment_error
    questions = []
    error_lines = []
    @lines.each_with_index do |line,index|
      if line.strip.start_with?('#')
        lines = clone_array @lines
        lines[index].sub!('#','').strip!

        q = Question.new(:short)
        q.name = "#{name}-#{num}-uncomment"
        q.text = @lang.text_for(:code1,lines_to_html(lines))
        q.shorts << (index+1)
        q.feedback = 'Comment symbol removed'
        questions << q
      elsif line.strip.size>0
        lines = clone_array @lines
        lines[index]='# ' + lines[index]

        q = Question.new(:short)
        q.name = "#{name}-#{num}-comment"
        q.text = @lang.text_for(:code1,lines_to_html(lines))
        q.shorts << (index+1)
        q.feedback = 'Comment symbol added'
        questions << q
      end
    end
    questions
  end

  def make_no_error_changes
    questions = []
    empty_lines = []
    used_lines = []
    @lines.each_with_index do |line,index|
      if line.strip.size.zero?
        empty_lines << index
      else
        used_lines << index
      end
    end

    used_lines.each do |index|
      lines = clone_array(@lines)
      lines.insert(index, ' ' * (rand(4).to_i + 1))
      if @lines.size < 4 || rand(2) == 0
        q = Question.new(:short)
        q.name = "#{name}-#{num}-codeok"
        q.text = @lang.text_for(:code1,lines_to_html(lines))
        q.shorts << '0'
        q.feedback = 'Code is OK'
        questions << q
      else
        q = Question.new(:choice)
        q.name = "#{name}-#{num}-codeok"
        q.text = @lang.text_for(:code2,lines_to_html(lines))
        others = (1..@lines.size).to_a.shuffle!
        q.good = '0'
        q.bads << others[0].to_s
        q.bads << others[1].to_s
        q.bads << others[2].to_s
        q.feedback = 'Code is OK'
      end
    end

    questions
  end

  def make_syntax_error
    questions = []

    @lang.mistakes.each_pair do |key,values|
      error_lines = []
      @lines.each_with_index do |line,index|
        error_lines << index if line.include?(key.to_s)
      end

      v = values.split(',')
      v.each do |value|
        error_lines.each do |index|
          lines = clone_array(@lines)
          lines[index].sub!(key.to_s, value)
          if @lines.size < 4 || rand(2) == 0
            q = Question.new(:short)
            q.name = "#{name}-#{num}-syntaxerror"
            q.text = @lang.text_for(:code1,lines_to_html(lines))
            q.shorts << (index+1)
            q.feedback = "Syntax error: '#{value}' must be '#{key}'"
          else
            q = Question.new(:choice)
            q.name = "#{name}-#{num}-syntaxerror"
            q.text = @lang.text_for(:code2,lines_to_html(lines))
            others = (1..@lines.size).to_a.shuffle!
            others.delete(index+1)
            q.good = (index + 1).to_s
            q.bads << others[0].to_s
            q.bads << others[1].to_s
            q.bads << others[2].to_s
            q.feedback = "Syntax error: '#{value}' must be '#{key}'"
          end
          questions << q
        end
      end
    end
    questions
  end

  def make_variable_error
    questions = []
    error_lines = []
    @lines.each_with_index do |line, index|
      # Search Variable assignment
      m = /\s*(\w*)\s*\=\w*/.match(line)
      i = []
      unless m.nil?
        varname = (m.values_at 1)[0]
        # Search used Variable
        @lines.each_with_index do |line2, index2|
          next if index >= index2
          i << index2 if line2.include?(varname)
        end
      end
      next if i.size == 0
      i.shuffle!
      i.each do |k|
        lines = clone_array @lines
        temp = lines[index]
        lines[index] = lines[k]
        lines[k] = temp

        if rand(2) == 0
          q = Question.new(:short)
          q.name = "#{name}-#{num}-variable"
          q.text = @lang.text_for(:code1,lines_to_html(lines))
          q.shorts << (index + 1)
          q.feedback = "Variable error! Swapped lines #{(index+1)} with #{(k+1)}"
        else
          q = Question.new(:choice)
          q.name = "#{name}-#{num}-variable"
          q.text = @lang.text_for(:code2,lines_to_html(lines))
          others = (1..@lines.size).to_a.shuffle!
          others.delete(index+1)
          q.good = (index + 1).to_s
          q.bads << others[0].to_s
          q.bads << others[1].to_s
          q.bads << others[2].to_s
          q.feedback = "Variable error! Swapped lines #{(index+1)} with #{(k+1)}"
        end
        questions << q
      end
    end
    questions
  end
end
