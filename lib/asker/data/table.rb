# frozen_string_literal: true

require_relative 'row'
require_relative 'template'

# Contains data table information
class Table
  attr_reader :name, :id
  attr_reader :fields, :sequence
  attr_reader :langs
  attr_reader :datarows # DEV: experimental replace for Row objects
  attr_reader :rows     # Row objects are Datarows.raws values
  # Table is simple when all their rows and col has the same lang and type value
  attr_reader :simple

  ##
  # initialize Table object
  # @param concept (Concept)
  # @param xml_data (XML)
  def initialize(concept, xml_data)
    @concept = concept
    read_attributes_from_xml(xml_data)

    @simple = { lang: true, type: true }
    @types  = ['text']        * @fields.size
    @langs  = [@concept.lang] * @fields.size

    @datarows = [] # DEV experiment replace row data with row objects
    read_data_from_xml(xml_data)
    @rows = @datarows.map(&:raws)
  end

  def to_s
    @name.to_s
  end

  def sequence?
    @sequence.size.positive?
  end

  ##
  # Return fields type:
  # * types(:all)  => Return an Array with all field types
  # * types(index) => Return type for fields[index]
  # @param index (Integer)
  def types(index = :all)
    @types = (['text'] * @fields.size) if @types.nil?
    return @types if index == :all

    @types[index]
  end

  ##
  # Set table to simple off
  # * simple_off(:lang) => Set table simple lang FALSE
  # * simple_off(:type) => Set table simple type FALSE
  # @param option (Symbol)
  def simple_off(option)
    @simple[option] = false
  end

  private

  ##
  # Fill:fields, name and id from XML input
  # @param xml_data (XML)
  def read_attributes_from_xml(xml_data)
    t = xml_data.attributes['fields'].to_s.strip.split(',')
    t.each(&:strip!)
    @fields = t || []

    @name = ''
    @fields.each { |i| @name = "#{@name}$#{i.to_s.strip.downcase}" }
    @id = "#{@concept.name}.#{@name}"

    @sequence = []
    return unless xml_data.attributes['sequence']

    @sequence = xml_data.attributes['sequence'].to_s.split(',')
  end

  def read_data_from_xml(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when 'lang'
        read_lang_from_xml(i)
      when 'row'
        @datarows << Row.new(self, @datarows.size, i)
      when 'sequence'
        @sequence = i.text.split(',')
      when 'template'
        @datarows += Template.new(self, @datarows.size, i).datarows
      when 'type'
        read_type_from_xml(i)
      else
        puts Rainbow("[ERROR] concept/table#xml_data with #{i.name}").red.bright
      end
    end
  end

  def read_lang_from_xml(xml_data)
    j = xml_data.text.split(',')
    codes = @langs.map(&:code)
    return if j.join(',') == codes.join(',')

    simple_off(:lang)
    @langs = []
    j.each do |k|
      if ['*', ''].include? k.strip
        @langs << @concept.lang
      else
        @langs << LangFactory.instance.get(k.strip.to_s)
      end
    end
  end

  def read_type_from_xml(xml_data)
    j = xml_data.text.split(",")
    return if j.join(",") == @types.join(",")

    simple_off(:type)
    @types = []
    j.each { |k| @types << k.strip.to_s }
  end
end
