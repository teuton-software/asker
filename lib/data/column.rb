# encoding: utf-8

class Column
  attr_reader :row, :index, :id, :raw, :lang, :type, :simple

  def initialize( pRow, index, pXMLdata )
    @row    = pRow
    @index  = index
    @id     = pRow.id + "." + @index.to_s
    @raw    = ""
    @lang   = @row.langs[@index]
    @type   = @row.types[@index]
    @simple = { :lang => true, :type => true }
    read_data_from_xml(pXMLdata)
  end

  def to_html
    case @type
    when "text"
      return @raw
    when "image_url"
      return "<img src=\"#{raw}\" alt\=\"image\">"
    when "textfile_path"
      return "<pre>#{raw}</pre>"
    else
      return "ERROR type #{@type}"
    end
  end

private
  def read_data_from_xml(pXMLdata)
    if pXMLdata.elements.count>0 then
      raise "[ERROR] Column: read data from xml"
    end
    @raw = pXMLdata.text.strip.to_s

    #read attributes from XML data
    if pXMLdata.attributes['lang'] then
      code = pXMLdata.attributes['lang'].strip
      if code != @lang.code then
        @lang = LangFactory.instance.get(code)
        @simple[:lang]= false
        @row.simple_off(:lang)
      end
    end

    if pXMLdata.attributes['type'] then
      type = pXMLdata.attributes['type'].strip
      if type != @type then
        @type = type
        @simple[:type]= false
        @row.simple_off(:type)
      end
    end
  end

end
