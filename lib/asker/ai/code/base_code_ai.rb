
require_relative '../../lang/lang_factory'
require_relative '../../ai/question'

##
# BaseCodeAI class
class BaseCodeAI
  ##
  # Return the name of code
  # @return String
  def name
    File.basename(@code.filename)
  end

  def num
    @num += 1
  end

  ##
  # Clone array
  # @param array (Array)
  # @return Array
  def clone_array(array)
    out = []
    array.each { |item| out << item.dup }
    out
  end

  ##
  # Convert an array of lines into one String
  # @param lines (Array)
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

  ##
  # Make questions
  def make_questions
    list = find_make_methods
    list.each { |m| @questions += self.send m }
    @questions
  end

  private

  def find_make_methods
    list = self.public_methods.sort
    list.select! { |name| name.to_s.start_with? 'make_'}
    list.delete(:make_questions)
    list
  end
end
