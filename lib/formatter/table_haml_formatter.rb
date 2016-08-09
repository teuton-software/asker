# encoding: utf-8

class TableHAMLFormatter

  def initialize(table)
    @table = table
  end

  def to_s
    out = ""
    out << "    %table{ :fields => \'#{@table.fields.join(",").to_s}\' }\n"

    if @table.fields.size==1 then
      @table.rows.each { |text| out << "      %row #{text}\n" }
    else
      @table.rows.each do |row|
        out << "      %row\n"
        row.each  { |text| out << "        %col #{text}\n" }
      end
    end
	  return out
  end

end
