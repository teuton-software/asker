# frozen_string_literal: true

# Contain data information for every column
# Params:
# * +pRow+ - Parent row for this column
# * +index+ - Sequence order (Integer)
# * +xml_data+ - XML input data
class Column
  attr_reader :row, :index, :id, :raw, :lang, :type, :simple

  ##
  # initialize Column
  # @param row (Row)
  # @param index (Integer)
  # @param xml_data (XMLdata)
  def initialize(row, index, xml_data)
    @row    = row
    @index  = index
    @id     = "#{@row.id}.#{@index}"
    @raw    = ''
    @lang   = @row.langs[@index]
    @type   = @row.types[@index]
    @simple = { lang: true, type: true }
    read_data_from_xml(xml_data)
  end

  def to_html
    case @type
    when 'text'
      return @raw
    when 'image_url'
      return "<img src=\"#{raw}\" alt\=\"image\">"
    when 'textfile_path'
      return "<pre>#{raw}</pre>"
    end
    "ERROR type #{@type}"
  end

  private

  def read_data_from_xml(xml_data)
    raise '[ERROR] Column with elements!' if xml_data.elements.count.positive?

    @raw = xml_data.text.strip.to_s

    # read attributes from XML input data
    read_lang_from_xml(xml_data)
    read_type_from_xml(xml_data)
  end

  def read_lang_from_xml(xml_data)
    return unless xml_data.attributes['lang']

    code = xml_data.attributes['lang'].strip
    return if code == @lang.code

    @lang = LangFactory.instance.get(code)
    @simple[:lang] = false
    @row.simple_off(:lang)
  end

  def read_type_from_xml(xml_data)
    return unless xml_data.attributes['type']

    type = xml_data.attributes['type'].strip
    return if type == @type.to_s

    @type = type
    @simple[:type] = false
    @row.simple_off(:type)
  end
end
