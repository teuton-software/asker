
require_relative '../../lang/lang_factory'
require_relative '../../ai/question'

class RubyCodeAI
  def initialize(data_object)
    @data_object = data_object
    @lines = data_object.lines
    @lang = LangFactory.instance.get('ruby')
    @num = 0
    @questions = []
  end

  def name
    File.basename(@data_object.filename)
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
      out << "%2d: #{line}\n"%(index+1)
    end
    out
  end

  def lines_to_html(lines)
    out = ''
    lines.each_with_index do |line,index|
      out << "%2d: #{line}</br>"%(index+1)
    end
    out
  end

  def make_questions
    @questions += make_comment_error
    @questions += make_no_error_changes
    @questions += make_syntax_error
    @questions
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
      lines.insert(index, ' ')
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
end
