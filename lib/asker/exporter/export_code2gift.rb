require_relative "../formatter/question_gift_formatter"

class ExportCode2Gift
  ##
  # Export an Array of codes to gift format file
  # @param codes (Array)
  def call(codes, file)
    codes.each { |code| export(code, file) }
  end

  private

  ##
  # Export 1 code to gift format file
  def export(code, file)
    return false unless code.process?

    file.write head(code)
    code.questions.each do |question|
      file.write QuestionGiftFormatter.to_s(question)
    end
    true
  end

  def head(code)
    s = "\n"
    s += "// " + "=" * 50 + "\n"
    s += "// Code #{code.type}: #{code.filename} (#{code.questions.size})\n"
    s += "// " + "=" * 50 + "\n"
    s
  end
end
