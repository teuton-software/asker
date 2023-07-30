class FormatCode2Doc
  def call(code)
    out = ""
    title = "#{code.filename} (#{code.type})"
    out << ("-" * title.size + "\n")
    out << "#{title}\n"
    if code.features.size.positive?
      out << "* features: #{code.features.join(", ")}"
    end
    out << "\n"
    code.lines.each_with_index do |line, index|
      out << "#{index} | #{line}\n"
    end
    out << "\n"
    out
  end
end
