# encoding: utf-8

require_relative 'row'
require_relative 'template'

# Contains data table information
class Table
  attr_reader :name, :id
  attr_reader :fields, :langs, :types, :sequence
  attr_reader :datarows, :rows
  attr_reader :simple

  def initialize(concept, xml_data)
    @concept = concept

    # read attributes from XML data
    t = xml_data.attributes['fields'].to_s.strip.split(',')
    t.each { |i| i.strip! }
    @fields = t || []
    @types  = ['text']        * @fields.size
    @langs  = [@concept.lang] * @fields.size

    @name   = ''
    @fields.each { |i| @name=@name + '$' + i.to_s.strip.downcase}
    @id     = @concept.name.to_s + '.' + @name
    @simple = { lang: true, type: true }

    @sequence = []
    if xml_data.attributes['sequence']
      t = xml_data.attributes['sequence'].to_s || ""
      @sequence = t.split(",")
      # puts "[DEPRECATED] sequence attr on table <#{@name}>"
    end

    @datarows = [] #DEV experiment replace row data with row objects
    read_data_from_xml(xml_data)
    @rows = @datarows.map { |r| r.raws }
  end

  def to_s
    @name.to_s
  end

  def sequence?
    @sequence.size > 0
  end

  def types(index = :all)
    @types = (['text'] * @fields.size) if @types.nil?
    return @types if index == :all
    @types[index]
  end

  def simple_off(option)
    @simple[option] = false
  end

  private

  def read_data_from_xml(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when 'lang'
        j = i.text.split(',')
        codes = @langs.map(&:code)

        if j.join(',') != codes.join(',')
          simple_off(:lang)
          @langs = []
          j.each do |k|
            if k.strip == '*' || k.strip == ''
              @langs << @concept.lang
            else
              @langs << LangFactory.instance.get(k.strip.to_s)
            end
          end
        end
      when 'row'
        @datarows << Row.new(self, @datarows.size, i)
      when 'sequence'
        @sequence = i.text.split(',')
      when 'template'
        @datarows += Template.new(self, @datarows.size, i).datarows
      when 'type'
        j = i.text.split(',')
        if j.join(',') != @types.join(',')
          simple_off(:type)
          @types = []
          j.each { |k| @types << k.strip.to_s }
        end
      else
        puts Rainbow("[ERROR] concept/table#xml_data with #{i.name}").red.bright
      end
    end
  end
end
