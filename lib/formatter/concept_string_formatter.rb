# encoding: utf-8

require 'rainbow'
require 'terminal-table'

require_relative '../project'

class ConceptStringFormatter

  def initialize(concept)
    @concept = concept
  end

  def to_s
    out=""

    t = Terminal::Table.new
    t.add_row [Rainbow(@concept.id.to_s).bright, Rainbow(@concept.name).color(:white).bg(:blue).bright+" (lang=#{@concept.lang}) " ]
    t.add_row [Rainbow("Filename").color(:blue), @concept.filename.to_s ]
    t.add_row [Rainbow("Context").color(:blue), @concept.context.join(", ").to_s ]
    t.add_row [Rainbow("Tags").color(:blue), @concept.tags.join(", ").to_s]

    lText=[]
    @concept.texts.each do |i|
      if i.size<60 then
	    lText << i.to_s
	  else
	    lText << i[0...70].to_s+"..."
	  end
	end
    t.add_row [Rainbow(".def(text)").color(:blue), lText.join("\n")]
    t.add_row [Rainbow(".def(images)").color(:blue), @concept.images.join(", ").to_s]
	  if @concept.tables.count>0 then
	    lText=[]
	    @concept.tables.each { |i| lText << i.to_s }
	    t.add_row [ Rainbow(".tables").color(:blue), lText.join("\n")]
	  end
	  lText=[]
	  @concept.neighbors[0..5].each { |i| lText << i[:concept].name+"("+i[:value].to_s[0..4]+")" }
	  t.add_row [Rainbow(".neighbors").color(:blue),lText.join("\n")]

    out << t.to_s+"\n"
	  return out
  end

end
