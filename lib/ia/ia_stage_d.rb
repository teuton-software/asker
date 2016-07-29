# encoding: utf-8

module IA_stage_d

  def run_stage_d(pTable, pList1, pList2)
    #process_table1field
    questions = []

    return questions if pTable.fields.count>1

    if pList1.count>3 then
      s=Set.new [ pList1[0][:data][0] ]
	    s << pList1[1][:data][0]
	    s << pList1[2][:data][0]
	    s << pList1[3][:data][0]
	    a=s.to_a
	    a.shuffle!

	    if a.count==4 then
        q=Question.new
        q.set_boolean
        q.name="#{name}-#{@num.to_s}-d1table-#{pTable.name}"
        q.text=@lang.text_for(:d1table, name, pTable.fields[0].capitalize, a[0], a[1], a[2], a[3])
        q.good="TRUE"
        questions << q
	    end
	  end

    if pList1.count>2 and pList2.count>0 then
	    s=Set.new [ pList1[0][:data][0] ]
	    s << pList1[1][:data][0]
	    s << pList1[2][:data][0]
	    s << pList2[0][:data][0]
	    a=s.to_a
	    a.shuffle!

	    if a.count==4 then
        q=Question.new
        q.set_boolean
        q.name="#{name}-#{@num.to_s}-d2table-#{pTable.name}"
        q.text=@lang.text_for(:d1table, name, pTable.fields[0].capitalize, a[0], a[1], a[2], a[3])
        q.good="FALSE"
        questions << q
	    end
	  end

    return questions
  end

end
