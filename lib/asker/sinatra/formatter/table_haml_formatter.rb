# frozen_string_literal: false

# Used by: concept_haml_formatter < sinatra_front_end < command/editor
class TableHAMLFormatter
  def initialize(table)
    @table = table
  end

  def to_s
    add_table_head + add_table_fields
  end

  private

  def add_table_head
    out = "    %table{:fields => \'#{@table.fields.join(', ')}\'"
    if @table.sequence?
      out << ", :sequence => \'#{@table.sequence.join(', ')}\'"
    end
    out << "}\n"
    out
  end

  def add_table_fields
    out = ''
    if @table.fields.size == 1
      @table.rows.each { |text| out << "      %row #{text[0]}\n" }
    else
      @table.rows.each do |row|
        out << "      %row\n"
        row.each { |text| out << "        %col #{text}\n" }
      end
    end
    out
  end
end
