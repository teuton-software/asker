# frozen_string_literal: false

require 'rainbow'
require 'terminal-table'

require_relative '../project'

##
# Formatter Concept to Doc
module ConceptDocFormatter
  ##
  # Formatter Concept into Doc
  # @param concept (Concept)
  def self.to_s(concept)
    out = ''
    out << "\n#{Rainbow(concept.name).bg(:blue).bright}\n\n"
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
