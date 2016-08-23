# encoding: utf-8

require_relative 'column'

class Row
  attr_reader :table, :index, :id, :langs, :types, :raws, :columns

  def initialize( pTable, index, pXMLdata )
    @table   = pTable
    @index   = index
    @id      = pTable.id + "." + @index.to_s
    @langs   = []
    @types   = []
    @raws    = []
    @columns = []

    read_data_from_xml(pXMLdata)
  end

private

  def read_data_from_xml(pXMLdata)
    if pXMLdata.elements.count==0 then
      # When row tag only has text, we add this text as one value array
      # This is usefull for tables with only one columns
      @raws = [ pXMLdata.text.strip.to_s ]
    else
      pXMLdata.elements.each do |i|
        case i.name
        when 'lang'
          j = i.text.split(",")
          @langs = []
          j.each { |k| @langs << LangFactory.instance.get(k.strip.to_s) }
        when 'col' # When row tag has several columns, we add every value to the array
          @raws << i.text.to_s
          #Column Objects
          @columns << Column.new( self, @raws.size, i)
        end
      end
    end
  end

end
