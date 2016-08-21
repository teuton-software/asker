# encoding: utf-8

class Row
  attr_reader :id, :raws, :langs, :types

  def initialize( pTable, order, pXMLdata )
    @table = pTable
    @order = order
    @id    = pTable.id + "." + order.to_s
    @raws  = []
    @langs = []
    @types = []

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
        end
      end
    end
  end

end
