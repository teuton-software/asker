require 'rainbow'
require 'rexml/document'

require_relative '../lang/lang_factory'
require_relative '../loader/embedded_file'
require_relative 'table'
require_relative 'data_field'

class Concept
  attr_reader :id        # Unique identifer (Integer)
  attr_reader :lang      # Lang object
  attr_reader :context   # Context inherits from map
  attr_reader :names     # Names used to identify or name this concept
  attr_reader :type      # type = text -> Name values are only text
  attr_reader :filename  # Filename where this concept is defined
  attr_reader :data      # Data about this concept
  attr_accessor :process # (Boolean) if it is necesary generate questions

  @@id = 0 # Global Concept counter (concept identifier)

  ##
  # Initilize Concept
  # @param xml_data (XML)
  # @param filename (String)
  # @param lang_code (String)
  # @param context (Array)
  def initialize(xml_data, filename, lang, context)
    @@id += 1
    @id = @@id

    @filename = filename
    @process = false
    @lang = lang # LangFactory.instance.get(lang_code)
    @context = context
    @names = ['concept.' + @id.to_s]
    @type  = 'text'

    @data = {}
    @data[:tags] = []
    @data[:texts] = []          # Used by standard def inputs
    @data[:images] = []         # Used by [type => file and type => image_url] def inputs
    @data[:tables] = []
    @data[:neighbors] = []
    @data[:reference_to] = []
    @data[:referenced_by] = []

    read_data_from_xml(xml_data)
  end

  def name(option = :raw)
    DataField.new(@names[0], @id, @type).get(option)
  end

  def text
    @data[:texts][0] || '...'
  end

  def process?
    @process
  end

  def try_adding_neighbor(other)
    p = calculate_nearness_to_concept(other)
    return if p.zero?

    @data[:neighbors] << { concept: other, value: p }
    # Sort neighbors list
    @data[:neighbors].sort! { |a, b| a[:value] <=> b[:value] }
    @data[:neighbors].reverse!
  end

  def calculate_nearness_to_concept(other)
    weights = ProjectData.instance.get(:weights).split(',').map(&:to_f)

    max1 = @context.count
    max2 = @data[:tags].count
    max3 = @data[:tables].count

    alike1 = alike2 = alike3 = 0.0

    # check if exists this items from concept1 into concept2
    @context.each { |i| alike1 += 1.0 unless other.context.index(i).nil? }
    @data[:tags].each { |i| alike2 += 1.0 unless other.tags.index(i).nil? }
    @data[:tables].each { |i| alike3 += 1.0 unless other.tables.index(i).nil? }

    alike = (alike1 * weights[0] + alike2 * weights[1] + alike3 * weights[2])
    max = (max1 * weights[0] + max2 * weights[1] + max3 * weights[2])
    (alike * 100.0 / max)
  end

  def try_adding_references(other)
    reference_to = 0
    @data[:tags].each do |i|
      reference_to += 1 unless other.names.index(i.downcase).nil?
    end
    @data[:texts].each do |t|
      text = t.clone
      text.split(' ').each do |word|
        reference_to += 1 unless other.names.index(word.downcase).nil?
      end
    end
    return unless reference_to.positive?

    @data[:reference_to] << other.name
    other.data[:referenced_by] << name
  end

  def tags
    @data[:tags]
  end

  def texts
    @data[:texts]
  end

  def images
    @data[:images]
  end

  def tables
    @data[:tables]
  end

  def neighbors
    @data[:neighbors]
  end

  def reference_to
    @data[:reference_to]
  end

  def referenced_by
    @data[:referenced_by]
  end

  private

  def read_data_from_xml(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when "names"
        process_names(i)
      when "tags"
        process_tags(i)
      when "def"
        process_def(i)
      when "table"
        @data[:tables] << Table.new(self, i)
      else
        text = "   [ERROR] Concept #{name} with unkown attribute: #{i.name}"
        puts Rainbow(text).color(:red)
      end
    end
  end

  def process_names(value)
    @names = []
    j = value.text.split(',')
    j.each { |k| @names << k.strip }
    @type = value.attributes['type'].strip if value.attributes['type']
  end

  def process_tags(value)
    if value.text.nil? || value.text.size.zero?
      puts Rainbow("[ERROR] Concept without tags: #{name} ").red.briht
      exit 1
    end

    @data[:tags] = value.text.split(',')
    @data[:tags].collect!(&:strip)
  end

  def process_def(value)
    case value.attributes["type"]
    when "image_url"
      # Link with remote image
      @data[:images] << EmbeddedFile.load(value.text.strip, File.dirname(@filename))
    when "file"
      # Load local images and text files
      @data[:images] << EmbeddedFile.load(value.text.strip, File.dirname(@filename))
    when nil
      if value.text.nil?
        warn Rainbow("[WARN] def: without text!").yellow.bright
      else
        @data[:texts] << value.text.strip
      end
    else
      msg = "[ERROR] Unknown type: #{value.attributes['type']}"
      puts Rainbow(msg).red.bright
      exit 1
    end
  end
end
