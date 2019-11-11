# encoding: utf-8

require_relative 'base_stage'
require_relative '../question'

class StageS < BaseStage

  def run(pTable, pList1, pList2)
    #process_sequence
    questions = []
    return questions unless ( pTable.fields.count==1 and pTable.sequence? and pTable.sequence[0]!="")

    #TODO
    #items=[]
    #pList1.each_with_index { |i,j| items<<[ i[:data][0], j] }
    #puts Rainbow(items).blue.bright

    #Question type <d3sequence>: items are part of a sequence
    if pList1.count>3
	    a=0..(pList1.count-4)
	    a.each_entry do |i|
        q=Question.new(:match)
        q.name="#{name}-#{num.to_s}-s1sequence-#{pTable.name}"
        q.text= random_image_for(name) + lang.text_for(:s1, name, pTable.fields[0].capitalize, pTable.sequence[0] )
        q.matching << [ pList1[i+0][:data][0], '1º' ]
        q.matching << [ pList1[i+1][:data][0], '2º' ]
        q.matching << [ pList1[i+2][:data][0], '3º' ]
        q.matching << [ pList1[i+3][:data][0], '4º' ]
        questions << q
      end
    end

    #Question type <d4sequence>: items are part of a reverse sequence
    if pList1.count>3 and pTable.sequence.size>1
	    a=0..(pList1.count-4)
	    a.each_entry do |i|
        q=Question.new
        q.set_match
        q.name="#{name}-#{num.to_s}-s2sequence-#{pTable.name}"
        q.text= random_image_for(name) + lang.text_for(:s1, name, pTable.fields[0].capitalize, pTable.sequence[1] )
        q.matching << [ pList1[i+3][:data][0], '1º' ]
        q.matching << [ pList1[i+2][:data][0], '2º' ]
        q.matching << [ pList1[i+1][:data][0], '3º' ]
        q.matching << [ pList1[i+0][:data][0], '4º' ]
        questions << q
      end
	  end

    return questions
  end

end
