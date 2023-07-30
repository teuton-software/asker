module QuestionGiftFormatter
  ##
  # Convert question object into gift formatted string
  # @param question (Question)
  # @return String
  def self.to_s(question)
    s = ""
    return s unless question.encode == :none

    # Return question using gift format
    cond = question.comment.nil? || question.comment.empty?
    s = "// #{question.comment}\n" unless cond
    s << "::#{question.name}::[html]#{sanitize(question.text)}\n"

    case question.type
    when :boolean
      s << "{#{question.good}#####{sanitize(question.feedback.to_s)}}\n\n"
    when :choice
      s += "{\n"
      a = ["  =#{sanitize(question.good)}\n"]
      penalties = ["", "%-50%", "%-33.33333%", "%-25%", "%-20%"]
      penalty = penalties[question.bads.size]

      question.bads.each { |i| a << ("  ~#{penalty}" + sanitize(i) + "\n") }
      a.shuffle! if question.shuffle?
      a.each do |i|
        text = i
        text = i[0, 220] + "...(ERROR: text too long)" if text.size > 255
        s << text
      end
      s += "  #####{sanitize(question.feedback.to_s)}\n" if question.feedback
      s += "}\n\n"
    when :ddmatch
      s << "// WARNING: can't export ddmatch questions to this format"
    when :gapfill
      s << "// WARNING: can't export gapfill questions to this format"
    when :match
      s << "{\n"
      a = []
      question.matching.each do |i, j|
        i = i[0, 220] + "...(ERROR: text too long)" if i.size > 255
        j = j[0, 220] + "...(ERROR: text too long)" if j.size > 255
        a << "  =#{sanitize(i)} -> #{sanitize(j)}\n"
      end
      a.shuffle! if question.shuffle?
      a.each { |i| s << i }
      s << "}\n\n"
    when :ordering
      s << "{>0 ALL VERTICAL ABSOLUTE_POSITION SHOW none\n"
      question.ordering.each { |i| s << "#{i}\n" }
      s << "}\n\n"
    when :short
      s << "{\n"
      question.shorts.uniq!
      question.shorts.each do |i|
        text = i
        text = i[0, 220] + "...(ERROR: too long)" if text.size > 255
        s << "  =%100%#{text}#\n"
      end
      s << "  #####{sanitize(question.feedback.to_s)}\n" if question.feedback
      s << "}\n\n"
    end
    s
  end

  ##
  # Sanitize gift text
  # @param input (String)
  # @return String
  def self.sanitize(input = "")
    return sanitize_exclude_pre(input) if input.include? '<pre>'

    output = input.dup
    output.gsub!("#", '\#')
    output.gsub!("\n", " ")
    output.gsub!(":", '\:')
    output.gsub!("=", '\=')
    output.gsub!("{", "\\{")
    output.gsub!("}", "\\}")

    output
  end

  def self.sanitize_exclude_pre(input = "")
    pres = input.split('<pre>')

    pres = [pres[0]] + pres[1].split("</pre>")
    [0, 2].each do |index|
      pres[index].gsub!("#", '\#')
      pres[index].gsub!("\n", " ")
      pres[index].gsub!(":", '\:')
      pres[index].gsub!("=", '\=')
      pres[index].gsub!("{", "\\{")
      pres[index].gsub!("}", "\\}")
    end

    pres.join("")
  end
end
