# encoding: utf-8

require 'rainbow'
require 'terminal-table'

require_relative '../project'

class ConceptDocFormatter

  def initialize(concept)
    @concept = concept
  end

  def to_s
    out = ""
    out << "\n"+Rainbow(@concept.name).bg(:blue).bright+"\n\n"

    @concept.texts.each { |i| out << "* "+i+"\n" }
    out << "\n"

    @concept.tables.each do |t|
      my_screen_table = Terminal::Table.new do |st|
        st << t.fields
        st << :separator
        t.rows.each { |r| st.add_row r }
      end
      out << my_screen_table.to_s+"\n"
    end

    return out
  end

end
