require_relative "../logger"

class Question2Hash
  def format(question)
    @question = question
    # Return question using YAML format
    s = {}
    s[:comment] = @question.comment
    s[:name] = @question.name
    s[:text] = sanitize(@question.text)
    s[:type] = @question.type
    s[:feedback] = sanitize(@question.feedback.to_s)
    case @question.type
    when :boolean
      s[:answer] = @question.good
    when :choice
      s[:answer] = sanitize(@question.good)
      s[:options] = (@question.bads + [@question.good]).shuffle
    when :ddmatch
      s[:answer] = @question.matching
    when :match
      s[:answer] = @question.matching
    when :ordering
      s[:answer] = @question.ordering
    when :short
      @question.shorts.uniq!
      s[:answer] = @question.shorts
    else
      Logger.warn "[WARN] Question2Hash: Unkown type (#{@question.type})"
    end
    s
  end

  private

  def sanitize(input = "")
    output = input.dup
    output.gsub!("#", "\\#")
    output.tr!("\n", " ")
    # output.gsub!(":", "\\:")
    output.gsub!("=", "\\=")
    output.gsub!("{", "\\{")
    output.gsub!("}", "\\}")
    output
  end
end
