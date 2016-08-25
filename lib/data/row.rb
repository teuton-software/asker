# encoding: utf-8

require_relative 'column'

class Row
  attr_reader :table, :index, :id
  attr_reader :langs, :types, :raws, :columns
  attr_reader :simple

  def initialize( pTable, index, pXMLdata )
    @table   = pTable
    @index   = index
    @id      = @table.id + "." + @index.to_s
    @langs   = @table.langs
    @types   = @table.types
    @raws    = []
    @columns = []
    @simple  = { :lang => true, :type => true }
    read_data_from_xml(pXMLdata)
  end

private

  def read_data_from_xml(pXMLdata)
    if pXMLdata.elements.count==0 then
      # When row tag only has text, we add this text as one value array
      # This is usefull for tables with only one columns
      @columns = [ Column.new( self, 0, pXMLdata) ]
      @raws    = [ pXMLdata.text.strip.to_s ]
    else
      pXMLdata.elements.each do |i|
        case i.name
        when 'lang'
          j = i.text.split(",")
          codes = @langs.map {|i| i.code  }

          if j.join(",")!=codes.join(",")
            @langs = []
            j.each { |k| @langs << LangFactory.instance.get(k.strip.to_s) }
            @simple[:lang]=false
          end
        when 'type'
          j = i.text.split(",")
          if j.join(",")!=@types.join(",") then
            @types = []
            j.each { |k| @types << k.strip.to_s }
            @simple[:type]=false
          end
        when 'col' # When row tag has several columns, we add every value to the array
          #Column Objects
          @columns << Column.new( self, @raws.size, i)
          @raws << i.text.to_s
        end
      end
    end

    if @simple[:lang] then
      @columns.each { |c|  @simple[:lang]=@simple[:lang] && c.simple[:lang] }

    end
    if @simple[:type] then
      @columns.each { |c|  @simple[:type]=@simple[:type] && c.simple[:type] }
    end

  end

end
