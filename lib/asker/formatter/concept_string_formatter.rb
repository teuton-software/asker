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
    t = Terminal::Table.new
    msg = Rainbow(concept.name(:screen)).white.bg(:blue).bright
    msg += " (lang=#{concept.lang.lang}) "
    t.add_row [Rainbow(concept.id.to_s).bright, msg]
    t.add_row [Rainbow('Filename').blue, concept.filename]
    t.add_row [Rainbow('Context').blue, concept.context.join(', ').to_s]
    t.add_row [Rainbow('Tags').blue, concept.tags.join(', ').to_s]
    t.add_row [Rainbow('Reference to').blue,
               concept.reference_to.join(', ')[0...70].to_s]
    t.add_row [Rainbow('Referenced by').blue,
               concept.referenced_by.join(', ')[0...70].to_s]
    t.add_row [Rainbow('.def(text)').blue, concept_texts_to_s(concept)]
    t.add_row [Rainbow('.def(images)').blue, concept.images.size.to_s]
    unless concept.tables.count.zero?
      ltext = []
      concept.tables.each { |i| ltext << i.to_s }
      t.add_row [Rainbow('.tables').color(:blue), ltext.join("\n")]
    end
    t.add_row [Rainbow('.neighbors').blue, concept_neighbors_to_s(concept)]

    "#{t}\n"
  end

  def self.concept_texts_to_s(concept)
    list = []
    concept.texts.each do |i|
      if i.size < 60
        list << i.to_s
      else
        list << i[0...70].to_s + '...'
      end
    end
    list.join("\n")
  end

  def self.concept_neighbors_to_s(concept)
    list = []
    concept.neighbors[0..5].each do |i|
      list << i[:concept].name(:screen) + '(' + i[:value].to_s[0..4] + ')'
    end
    list.join("\n")
  end
end
