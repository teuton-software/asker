
# Transform Questions into YAML format
module QuestionHashFormatter
  def self.to_hash(question)
    @question = question
    # Return question using YAML format
    s = {}
    s[:comment] = @question.comment
    s[:name] = @question.name
    s[:text] = sanitize(@question.text)
    s[:type] = @question.type
    s[:feedback] = sanitize(@question.feedback.to_s)
    s[:lang] = @question.lang.code.to_sym
    case @question.type
    when :choice
      s[:answer] = sanitize(@question.good)
      s[:options] = (@question.bads + [@question.good]).shuffle
    when :boolean
      s[:answer] = @question.good
    when :match
      s[:answer] = @question.matching
      s[:matching] = @question.matching
    when :short
      @question.shorts.uniq!
      s[:answer] = @question.shorts
    end
    s
  end

  def self.sanitize(input = '')
    output = input.dup
    output.gsub!("#", "\\#")
    output.gsub!("\n", " ")
    #output.gsub!(":", "\\:")
    output.gsub!("=", "\\=")
    output.gsub!("\{", "\\{")
    output.gsub!("\}", "\\}")
    output
  end
end
