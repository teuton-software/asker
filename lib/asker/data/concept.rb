# frozen_string_literal: true

require 'rainbow'
require 'rexml/document'

require_relative '../application'
require_relative '../logger'
require_relative '../lang/lang_factory'
require_relative 'table'
require_relative 'data_field'

##
# Store Concept information
class Concept
  attr_reader :id, :lang, :context
  attr_reader :names, :type, :filename
  attr_reader :data
  attr_accessor :process

  @@id = 0    # Concept counter

  ##
  # Initilize Concept
  # @param xml_data (XML)
  # @param filename (String)
  # @param lang_code (String)
  # @param context (Array)
  def initialize(xml_data, filename, lang_code = 'en', context = [])
    @@id += 1
    @id = @@id

    @filename = filename
    @process = false
    @lang = LangFactory.instance.get(lang_code)

    if context.class == Array
      @context = context
    elsif context.nil?
      @context = []
    else
      @context = context.split(',')
      @context.collect!(&:strip)
    end
    @names = ['concept.' + @id.to_s]
    @type  = 'text'

    @data = {}
    @data[:tags] = []
    @data[:texts] = []
    @data[:images] = []         # TODO: By now, We'll treat images separated from texts
    @data[:textfile_paths] = [] # TODO: By now, We'll treat this separated from texts
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
    a = Application.instance.config['ai']['formula_weights']
    weights = a.split(',').map(&:to_f)

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

  # rubocop:disable Metrics/MethodLength
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
  # rubocop:enable Metrics/MethodLength

  def method_missing(method)
    @data[method]
  end

  private

  # rubocop:disable Metrics/MethodLength
  def read_data_from_xml(xml_data)
    xml_data.elements.each do |i|
      case i.name
      when 'names'
        process_names(i)
      when 'tags'
        process_tags(i)
      when 'def'
        process_def(i)
      when 'table'
        @data[:tables] << Table.new(self, i)
      else
        text = "   [ERROR] <#{i.name}> unkown XML attribute for concept #{name}"
        Logger.verbose Rainbow(text).color(:red)
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def process_names(value)
    @names = []
    j = value.text.split(',')
    j.each { |k| @names << k.strip }
    @type = value.attributes['type'].strip if value.attributes['type']
  end

  def process_tags(value)
    if value.text.nil? || value.text.size.zero?
      raise '[Error] tags label empty!'
    end

    @data[:tags] = value.text.split(',')
    @data[:tags].collect!(&:strip)
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def process_def(value)
    case value.attributes['type']
    when 'image'
      msg = "[DEBUG] Concept#read_xml: image #{Rainbow(value.text).bright}"
      Project.instance.verbose Rainbow(msg).yellow
    when 'image_url'
      @data[:images] << value.text.strip
    when 'textfile_path'
      @data[:textfile_paths] << value.text.strip
    else
      @data[:texts] << value.text.strip
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
