
require 'rexml/document'
require_relative 'row'

class Template
  attr_reader :rows

  def initialize( table, index, data )
    @table   = table
    @index   = index
    @rows    = []
    @data    = data.to_s
    @vars    = {}
    to_xml(data)
    puts @vars
  end

  def to_xml(data)
    begin
      xml = REXML::Document.new(data)
      vars = xml.root.attributes
      vars.keys.each { |i| @vars[i]=vars[i] }

    rescue REXML::ParseException
      msg = Rainbow("[ERROR] Template ").red+Rainbow(data).red.bright
      puts msg
      raise msg
    end
  end

=begin
lXMLdata.root.elements.each do |xmldata|
  if xmldata.name=='concept' then
    c = Concept.new(xmldata, @filename, lLang, lContext)
    if ( project.process_file==:default or project.process_file== File.basename(@filename) ) then
      c.process=true
    end
    @concepts << c
  end
end

=end
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
