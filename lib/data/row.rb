
require_relative 'column'

class Row
  attr_reader :table, :index, :id
  attr_reader :langs, :types, :raws, :columns
  attr_reader :simple

  def initialize( table, index, xml_data )
    @table   = table
    @index   = index
    @id      = @table.id + "." + @index.to_s
    @langs   = @table.langs
    @types   = @table.types
    @raws    = []
    @columns = []
    @simple  = { :lang => true, :type => true }
    read_data_from_xml(xml_data)
  end

  def simple_off(option)
    @simple[option]=false
    @table.simple_off(option)
  end

private

  def read_data_from_xml(pXMLdata)
    if pXMLdata.elements.count==0 then
      build_row_with_1_column(pXMLdata)
    else
      build_row_with_N_columns(pXMLdata)
    end

    raise "[ERROR] Row: #{pXMLdata}" if @columns.size!=@table.fields.size
  end

  def build_row_with_1_column(pXMLdata)
    # When row tag only has text, we add this text as one value array
    # This is usefull for tables with only one columns
    @columns = [ Column.new( self, @raws.size, pXMLdata) ]
    @raws    = [ pXMLdata.text.strip.to_s ]

    #read attributes from XML data
    if pXMLdata.attributes['lang'] then
      code = pXMLdata.attributes['lang'].strip
      if code != @langs[0].code then
        @langs = [ LangFactory.instance.get(code) ]
        @simple[:lang]= false
        @table.simple_off(:lang)
      end
    end

    if pXMLdata.attributes['type'] then
      type = pXMLdata.attributes['type'].strip
      if type != @types[0] then
        @types = [ type ]
        @simple[:type]= false
        @table.simple_off(:type)
      end
    end
  end

  def build_row_with_N_columns(pXMLdata)
    pXMLdata.elements.each do |i|
      case i.name
      when 'lang'
        j = i.text.split(",")
        codes = @langs.map {|i| i.code  }

        if j.join(",")!=codes.join(",")
          @langs = []
          j.each { |k| @langs << LangFactory.instance.get(k.strip.to_s) }
          @simple[:lang]=false
          @table.simple_off(:lang)
        end
      when 'type'
        j = i.text.split(",")
        if j.join(",")!=@types.join(",") then
          @types = []
          j.each { |k| @types << k.strip.to_s }
          @simple[:type]=false
          @table.simple_off(:type)
        end
      when 'col' # When row tag has several columns, we add every value to the array
        #Column Objects
        @columns << Column.new( self, @raws.size, i)
        @raws << i.text.to_s
      end
    end
  end

end
