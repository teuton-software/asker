# frozen_string_literal: true

require_relative 'column'

##
# Row objects
class Row
  attr_reader :table, :index, :id
  attr_reader :langs, :types, :raws, :columns
  attr_reader :simple

  ##
  # Initialize Row Object
  # @param table (Table)
  # @param index (Integer)
  # @param xml_data (XML)
  def initialize(table, index, xml_data)
    @table   = table
    @index   = index
    @id      = "#{@table.id}.#{@index}"
    @langs   = @table.langs
    @types   = @table.types
    @raws    = []
    @columns = []
    @simple  = { lang: true, type: true }
    read_data_from_xml(xml_data)
  end

  def simple_off(option)
    @simple[option] = false
    @table.simple_off(option)
  end

  private

  def read_data_from_xml(xml_data)
    if xml_data.elements.count.zero?
      build_row_with_1_column(xml_data)
    else
      build_row_with_n_columns(xml_data)
    end

    raise "[ERROR] Row: #{xml_data}" unless @columns.size == @table.fields.size
  end

  def build_row_with_1_column(xml_data)
    # When row tag only has text, we add this text as one value array
    # This is usefull for tables with only one columns
    @columns = [Column.new(self, @raws.size, xml_data)]
    @raws    = [xml_data.text.strip.to_s]

    # read attributes from XML data
    read_lang_from_xml(xml_data)
    read_type_from_xml(xml_data)
  end

  def read_lang_from_xml(xml_data)
    return unless xml_data.attributes['lang']

    code = xml_data.attributes['lang'].strip
    return if code == @langs[0].code

    @langs = [LangFactory.instance.get(code)]
    @simple[:lang] = false
    @table.simple_off(:lang)
  end

  def read_type_from_xml(xml_data)
    return unless xml_data.attributes['type']

    type = xml_data.attributes['type'].strip
    return if type == @types[0]

    @types = [type]
    @simple[:type] = false
    @table.simple_off(:type)
  end

  # rubocop:disable Metrics/MethodLength
  def build_row_with_n_columns(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when 'lang'
        read_langs_from_xml(i)
      when 'type'
        read_types_from_xml(i)
      when 'col'
        # When row has several columns, we add every value to the array
        @columns << Column.new(self, @raws.size, i) # Column Objects
        @raws << i.text.to_s
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def read_langs_from_xml(xml_data)
    j = xml_data.text.split(',')
    codes = @langs.map(&:code)
    return if j.join(',') == codes.join(',')

    @langs = []
    j.each { |k| @langs << LangFactory.instance.get(k.strip.to_s) }
    @simple[:lang] = false
    @table.simple_off(:lang)
  end

  def read_types_from_xml(xml_data)
    j = xml_data.text.split(',')
    return if j.join(',') == @types.join(',')

    @types = []
    j.each { |k| @types << k.strip.to_s }
    @simple[:type] = false
    @table.simple_off(:type)
  end
end
