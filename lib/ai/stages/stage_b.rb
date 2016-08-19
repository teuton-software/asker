# encoding: utf-8
# encoding: utf-8

require_relative 'base_stage'
require_relative '../question'

class StageB < BaseStage
	#range b1-b2

  def run(pTable, pList1, pList2)
    #process table match
    questions = []

    return questions if pTable.fields.count<2

    if pTable.fields.count>1 then
      questions += process_table_match2fields(pTable, pList1, pList2, 0, 1)
    elsif pTable.fields.count>2 then
      questions += process_table_match2fields(pTable, pList1, pList2, 0, 2)
      questions += process_table_match2fields(pTable, pList1, pList2, 1, 2)
    elsif pTable.fields.count>3 then
      questions += process_table_match2fields(pTable, pList1, pList2, 0, 3)
      questions += process_table_match2fields(pTable, pList1, pList2, 1, 3)
      questions += process_table_match2fields(pTable, pList1, pList2, 2, 3)
    end

    return questions
	end

  def process_table_match2fields(pTable, pList1, pList2, pIndex1, pIndex2)
    questions = []

    if pList1.count>3 then
      #Question type <b1match>: match items from the same table
      q=Question.new
      q.set_match
      q.name="#{name}-#{num.to_s}-b1match-#{pTable.name}"
      q.text=lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
      q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
      q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
      q.matching << [ pList1[3][:data][pIndex1], pList1[3][:data][pIndex2] ]
      questions << q

      #Question type <b1match>: match 3 items from table-A and 1 item with error
      q=Question.new
      q.set_match
      q.name="#{name}-#{num.to_s}-b1match-#{pTable.name}"
      q.text=lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
      q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
      q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
      q.matching << [ lang.do_mistake_to(pList1[3][:data][pIndex1]), lang.text_for(:error) ]
      questions << q

    end

    if pList1.count>7 then
      q=Question.new
      q.set_match
      q.name="#{name}-#{num.to_s}-b1match-#{pTable.name}"
      q.text=lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[4][:data][pIndex1], pList1[4][:data][pIndex2] ]
      q.matching << [ pList1[5][:data][pIndex1], pList1[5][:data][pIndex2] ]
      q.matching << [ pList1[6][:data][pIndex1], pList1[6][:data][pIndex2] ]
      q.matching << [ pList1[7][:data][pIndex1], pList1[7][:data][pIndex2] ]
      questions << q
    end

    if pList1.count>11 then
      q=Question.new
      q.set_match
      q.name="#{name}-#{num.to_s}-b1match-#{pTable.name}"
      q.text=lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[8][:data][pIndex1], pList1[8][:data][pIndex2] ]
      q.matching << [ pList1[9][:data][pIndex1], pList1[9][:data][pIndex2] ]
      q.matching << [ pList1[10][:data][pIndex1], pList1[10][:data][pIndex2] ]
      q.matching << [ pList1[11][:data][pIndex1], pList1[11][:data][pIndex2] ]
      questions << q
    end

    if pList1.count>2 and pList2.count>0 then
      s=Set.new
      pList1.each { |i| s.add( i[:data][pIndex1]+"<=>"+i[:data][pIndex2] ) }
      s.add( pList2[0][:data][pIndex1]+"<=>"+pList2[0][:data][pIndex2] )
      a=s.to_a

      #Question type <b2match>: 3 items from table-A, and 1 item from table-B
      if s.count>3 then
        q=Question.new
        q.set_match
        q.name="#{name}-#{num.to_s}-b2match-#{pTable.name}"
        q.text=lang.text_for(:b2match, name , pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize)
        q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
        q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
        q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
        q.matching << [ pList2[0][:data][pIndex1], lang.text_for(:error) ]
        questions << q
      end
    end

    return questions
  end

end
