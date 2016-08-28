# encoding: utf-8

require_relative 'row'

class Table
  attr_reader :name, :id
  attr_reader :fields, :langs, :types
  attr_reader :datarows
  attr_reader :simple

  def initialize(pConcept, pXMLdata)
    @concept = pConcept

    #read attributes from XML data
    @sequence = []
    if pXMLdata.attributes['sequence'] then
      t = pXMLdata.attributes['sequence'].to_s || ""
      @sequence = t.split(",")
      #puts "[DEPRECATED] sequence attr #{@name}"
    end

    t = pXMLdata.attributes['fields'].to_s.strip.split(',')
    t.each { |i| i.strip! }
    @fields = t || []
    @types  = ['text']        * @fields.size
    @langs  = [@concept.lang] * @fields.size

    @name   = ""
    @fields.each { |i| @name=@name+"$"+i.to_s.strip.downcase}
    @id    = @concept.name.to_s + "." + @name
    @simple = { :lang => true, :type => true }

    @datarows = [] #DEV experiment replace row data with row objects
    read_data_from_xml(pXMLdata)
    @rows = @datarows.map { |r| r.raws }
  end

  def to_s
    @name.to_s
  end

  def rows
    @rows
  end

  def sequence?
    return @sequence.size>0
  end

  def sequence
    return @sequence
  end

  def types(index=:all)
    @types = ( ["text"]*@fields.size) if @types.nil?
    return @types if index==:all
    return @types[index]
  end

  def simple_off(option)
    @simple[option]=false
  end

private

  def read_data_from_xml(pXMLdata)
    pXMLdata.elements.each do |i|
      case i.name
      when 'lang'
        j = i.text.split(",")
        codes = @langs.map{ |i| i.code }

        if j.join(",")!=codes.join(",") then
          simple_off(:lang)
          @langs = []
          j.each do |k|
            if k.strip=='*' or k.strip=='' then
              @langs << @concept.lang
            else
              @langs << LangFactory.instance.get(k.strip.to_s)
            end
          end
        end
      when 'type'
        j = i.text.split(",")
        if j.join(",")!=@types.join(",") then
          simple_off(:type)
          @types = []
          j.each { |k| @types << k.strip.to_s }
        end
      when 'sequence'
        @sequence= i.text.split(",")
      when 'row'
        @datarows << Row.new(self, @datarows.size, i)
      else
        puts Rainbow("[ERROR] concept/table#XMLdata with #{i.name}").red.bright
      end
    end
  end

end
