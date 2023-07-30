require "terminal-table"

class FormatConcept2Doc
  def call(concept)
    out = ""
    title = concept.names.join(", ")
    out << ("-" * title.size + "\n")
    out << "#{title}\n"
    concept.texts.each { |text| out << "* #{text}\n" }
    concept.images.each do |data|
      out << "* (#{data[:type]}) #{data[:url]}\n"
    end
    out << "\n"
    concept.tables.each do |table|
      out << format_table(table)
    end
    out
  end

  private

  def format_table(table)
    my_screen_table = Terminal::Table.new do |st|
      st << table.fields
      st << :separator
      table.rows.each { |r| st.add_row r }
    end
    "#{my_screen_table}\n"
  end
end
