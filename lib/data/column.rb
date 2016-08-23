# encoding: utf-8

class Column
  attr_reader :raw, :lang, :type

  def initialize( pRow, index, pXMLdata )
    @row   = pRow
    @index = index
    @raw   = ""
    @lang  = pRow.langs[@index]
    @type  = "text"

    read_data_from_xml(pXMLdata)
  end

private
  def read_data_from_xml(pXMLdata)
    if pXMLdata.elements.count>0 then
      raise "[ERROR] Column: read data from xml"
    end
    @raw = pXMLdata.text.strip.to_s

    #read attributes from XML data
    if pXMLdata.attributes['lang'] then
      @lang = LangFactory.instance.get( pXMLdata.attributes['lang'].strip )
    end

    if pXMLdata.attributes['type'] then
      @type = pXMLdata.attributes['type'].strip
    end
  end

end
