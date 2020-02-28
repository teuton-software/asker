# frozen_string_literal: true

require 'rainbow'
require 'terminal-table'

# Define methods to transform Concept into String
module ConceptStringFormatter
  ##
  # Formatter Concept to String
  # @param concept (Concept)
  # @return String
  def self.to_s(concept)
    tt = Terminal::Table.new
    get_tt_rows(concept).each { |row| tt.add_row row }
    "#{tt}\n"
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Layout/LineLength
  private_class_method def self.get_tt_rows(concept)
    rows = []
    rows << [Rainbow(concept.id.to_s).bright,
             Rainbow(concept.name(:screen)).white.bg(:blue).bright +
             " (lang=#{concept.lang.lang}) "]
    rows << [Rainbow('Filename').blue, concept.filename]
    rows << [Rainbow('Context').blue, concept.context.join(', ').to_s]
    rows << [Rainbow('Tags').blue, concept.tags.join(', ').to_s]
    rows << [Rainbow('Reference to').blue,
             concept.reference_to.join(', ')[0...70].to_s]
    rows << [Rainbow('Referenced by').blue,
             concept.referenced_by.join(', ')[0...70].to_s]
    rows << format_texts(concept)
    rows << [Rainbow('.def(images)').blue, concept.images.size.to_s] unless concept.images.size.zero?
    rows << format_tables(concept) unless concept.tables.count.zero?
    rows << format_neighbors(concept)
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Layout/LineLength

  private_class_method def self.format_texts(concept)
    list = []
    concept.texts.each do |i|
      if i.size < 60
        list << i.to_s
        next
      end
      list << i[0...70].to_s + '...'
    end
    [Rainbow('.def(text)').blue, list.join("\n")]
  end

  private_class_method def self.format_tables(concept)
    return [] if concept.tables.count.zero?

    list = concept.tables.map(&:to_s)
    [Rainbow('.tables').color(:blue), list.join("\n")]
  end

  private_class_method def self.format_neighbors(concept)
    list = concept.neighbors[0..4].map do |i|
      i[:concept].name(:screen) + '(' + i[:value].to_s[0..4] + ')'
    end
    [Rainbow('.neighbors').blue, list.join("\n")]
  end
end
