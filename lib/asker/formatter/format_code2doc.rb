require "terminal-table"

class FormatCode2Doc
  def call(code)
    out = ""
    title = code.filename
    out << ("-" * title.size + "\n")
    out << "#{title}\n"
    out << "* type: #{code.type}\n"
    if code.features.size.positive?
      out << "* features: #{code.features.join(", ")}"
    end
    out << "\n"
    screen_table = Terminal::Table.new do |st|
      # code.lines.each { |line| st.add_row line }
    end
    # out << "#{screen_table}\n"
    out
  end
end
