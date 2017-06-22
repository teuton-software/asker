
require_relative '../../lang/lang_factory'
require_relative '../../ai/question'

class BaseCodeAI
  def name
    File.basename(@data_object.filename)
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
end
