# encoding: utf-8

require_relative 'row'

class Table
  attr_reader :name, :id, :fields, :langs, :rows
  attr_accessor :rowobjects

  def initialize(pConcept, pXMLdata)
    @concept = pConcept

    #read attributes from XML data
    t = pXMLdata.attributes['sequence'].to_s || ""
    @sequence = t.split(",")

    t = pXMLdata.attributes['fields'].to_s.strip.split(',')
    t.each { |i| i.strip! }
    @fields = t || []

    @name  = ""
    @fields.each { |i| @name=@name+"$"+i.to_s.strip.downcase}
    @id    = @concept.name.to_s + "." + @name

    @langs = [ pConcept.lang ] * @fields.size #default lang values
    @rows  = []
    @rowobjects = [] #DEV experiment replace row data with row objects
    read_data_from_xml(pXMLdata)
  end

  def to_s
    @name.to_s
  end

  def sequence?
    return @sequence.size>0
  end

  def sequence
    return @sequence
  end

private

  def read_data_from_xml(pXMLdata)
    pXMLdata.elements.each do |i|
      case i.name
      when 'lang'
        j = i.text.split(",")
        @langs = []
        j.each { |k| @langs << LangFactory.instance.get(k.strip.to_s) }
      when 'sequence'
        @sequence= i.text.split(",")
      when 'row'
        row=[]
        if i.elements.count>0 then # When row tag has several columns, we add every value to the array
          i.elements.each { |j| row << j.text.to_s}
        else
          # When row tag only has text, we add this text as one value array
          # This is usefull for tables with only one columns
          row = [i.text.strip]
        end
        @rows << row
        @rowobjects << Row.new(self, 0, i)
      else
        puts Rainbow("[ERROR] concept/table#XMLdata with #{i.name}").red.bright
      end
    end
  end

end
