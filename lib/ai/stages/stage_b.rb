# encoding: utf-8

require 'set'

require_relative 'base_stage'
require_relative '../question'

class StageB < BaseStage
  # range b1

  def run(pTable, pList1, pList2)
    # process table match
    questions = []
    return questions if pTable.fields.count < 2

    return questions unless type == 'text'

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

    questions
  end

  def process_table_match2fields(pTable, pList1, pList2, pIndex1, pIndex2)
    questions = []

    if pList1.count>3
      pList1.each_cons(4) do |e1,e2,e3,e4|
        e = [ e1, e2, e3, e4 ]

        #Question type <b1match>: match 4 items from the same table
        e.shuffle!
        q=Question.new(:match)
        q.name="#{name}-#{num.to_s}-b1match4x4-#{pTable.name}"
        q.text= random_image_for(name) + lang.text_for(:b1, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
        q.matching << [ e[0][:data][pIndex1], e[0][:data][pIndex2] ]
        q.matching << [ e[1][:data][pIndex1], e[1][:data][pIndex2] ]
        q.matching << [ e[2][:data][pIndex1], e[2][:data][pIndex2] ]
        q.matching << [ e[3][:data][pIndex1], e[3][:data][pIndex2] ]
        questions << q

        # Question type <b1match>: match 3 items from table-A and 1 item with error
        e.shuffle!
        q=Question.new(:match)
        q.name="#{name}-#{num.to_s}-b1match3x1misspelled-#{pTable.name}"
        q.text= random_image_for(name) + lang.text_for(:b1, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
        q.matching << [ e[0][:data][pIndex1], e[0][:data][pIndex2] ]
        q.matching << [ e[1][:data][pIndex1], e[1][:data][pIndex2] ]
        q.matching << [ e[2][:data][pIndex1], e[2][:data][pIndex2] ]
        q.matching << [ lang.do_mistake_to(e[3][:data][pIndex1]), lang.text_for(:misspelling) ]
        questions << q
      end
    end

    if pList1.count>2 and pList2.count>0
      s=Set.new
      pList1.each do |i|
        s.add( i[:data][pIndex1]+"<=>"+i[:data][pIndex2] )
      end
      s.add( pList2[0][:data][pIndex1]+"<=>"+pList2[0][:data][pIndex2] )
      a=s.to_a

      # Question 3 items from table-A, and 1 item from table-B
      if s.count > 3
        q=Question.new(:match)
        q.name="#{name}-#{num.to_s}-b1match3x1-#{pTable.name}"
        q.text= random_image_for(name) + lang.text_for(:b1, name , pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize)
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
