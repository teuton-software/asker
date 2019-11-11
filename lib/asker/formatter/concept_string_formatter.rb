# encoding: utf-8

require 'rainbow'
require 'terminal-table'

# Define methods to trasnforme Concept into String
module ConceptStringFormatter
  def self.to_s(concept)
    out = ''

    t = Terminal::Table.new
    msg = Rainbow(concept.name(:screen)).white.bg(:blue).bright
    msg += " (lang=#{concept.lang.lang}) "
    t.add_row [Rainbow(concept.id.to_s).bright, msg]
    t.add_row [Rainbow('Filename').blue, concept.filename]
    t.add_row [Rainbow('Context').blue, concept.context.join(', ').to_s]
    t.add_row [Rainbow('Tags').blue, concept.tags.join(', ').to_s]
    msg = concept.reference_to.join(', ')[0...70].to_s
    t.add_row [Rainbow('Reference to').blue, msg]
    msg = concept.referenced_by.join(', ')[0...70].to_s
    t.add_row [Rainbow('Referenced by').blue, msg]

    ltext = []
    concept.texts.each do |i|
      if i.size < 60
        ltext << i.to_s
      else
        ltext << i[0...70].to_s + '...'
      end
    end
    t.add_row [Rainbow('.def(text)').blue, ltext.join("\n")]
    t.add_row [Rainbow('.def(images)').blue, concept.images.size.to_s]
    if concept.tables.count > 0
      ltext = []
      concept.tables.each { |i| ltext << i.to_s }
      t.add_row [Rainbow('.tables').color(:blue), ltext.join("\n")]
    end
    ltext = []
    concept.neighbors[0..5].each do |i|
      ltext << i[:concept].name(:screen) + '(' + i[:value].to_s[0..4] + ')'
    end
    t.add_row [Rainbow('.neighbors').blue, ltext.join("\n")]

    out << t.to_s + "\n"
    out
  end
end
