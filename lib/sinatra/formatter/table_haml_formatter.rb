# encoding: utf-8

class TableHAMLFormatter
  def initialize(table)
    @table = table
  end

  def to_s
    out =  "    %table{:fields => \'#{@table.fields.join(", ").to_s}\'"
    if @table.sequence?
      out << ", :sequence => \'#{@table.sequence.join(", ")}\'"
    end
    out << "}\n"

    if @table.fields.size==1 then
      @table.rows.each { |text| out << "      %row #{text[0].to_s}\n" }
    else
      @table.rows.each do |row|
        out << "      %row\n"
        row.each  { |text| out << "        %col #{text.to_s}\n" }
      end
    end
	  out
  end
end
