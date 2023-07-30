# frozen_string_literal: false

require "terminal-table"

module ConceptDocFormatter
  ##
  # Formatter Concept into Doc
  # @param concept (Concept)
  def self.to_s(concept)
    out = ""
    out << ("=" * 50 + "\n")
    out << "#{concept.names.join(", ")}\n"
    concept.texts.each { |i| out << "* #{i}\n" }
    out << "\n"
    concept.tables.each do |table|
      out << table_to_s(table)
    end
    out
  end

  ##
  # Formatter Table to Doc
  # @param table (Table)
  # @return String
  def self.table_to_s(table)
    my_screen_table = Terminal::Table.new do |st|
      st << table.fields
      st << :separator
      table.rows.each { |r| st.add_row r }
    end
    "#{my_screen_table}\n"
  end
end
