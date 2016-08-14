# encoding: utf-8

class Table
  attr_reader :name, :data, :lang

  def initialize(pConcept, pXMLdata)
    @concept = pConcept
    @lang    = pConcept.lang
    @name    = ""

    @data={}
    @data[:fields]=[]
    @data[:rows]=[]

    @data[:fields]=pXMLdata.attributes['fields'].to_s.strip.split(',')
    @data[:fields].each { |i| i.strip! }
    @data[:fields].each { |i| @name=@name+"$"+i.to_s.strip.downcase}

    lText=pXMLdata.attributes['sequence'].to_s || ""
    @data[:sequence]=lText.split(",")

    read_data_from_xml(pXMLdata)
  end

  def to_s
    @name.to_s
  end

  def sequence?
    return @data[:sequence].size>0
  end

  def sequence
    return @data[:sequence]
  end

  def method_missing(m, *args, &block)
    return @data[m]
  end

private

  def read_data_from_xml(pXMLdata)
    pXMLdata.elements.each do |i|
      case i.name
      when 'lang'
        @lang = LangFactory.instance.get(i.text.strip.to_s)
      when 'row'
        row=[]
        if i.elements.count>0 then
          # When row tag has several columns, we add every value to the array
          i.elements.each { |j| row << j.text.to_s}
          @data[:rows] << row
        else
          # When row tag only has text, we add this text as one value array
          # This is usefull for tables with only one columns
          @data[:rows] << [i.text.strip]
        end
      else
        puts Rainbow("[ERROR] concept/table#XMLdata with #{i.name}").red.bright
      end
    end
  end

end
