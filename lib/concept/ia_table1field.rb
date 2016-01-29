# encoding: utf-8

module IA_table1field

  def process_table1field(pTable, pList1, pList2)
    return if pTable.fields.count>1

    if pList1.count>3 then
	  s=Set.new [ pList1[0][:data][0] ]
	  s << pList1[1][:data][0]
	  s << pList1[2][:data][0]
	  s << pList1[3][:data][0]
	  a=s.to_a
	  a.shuffle!
	 
	  if a.count==4 then
        q=Question.new
        @num+=1
        q.init
        q.set_boolean
        q.name="#{name}-#{@num.to_s}-d1table-#{pTable.name}"
        q.text=@lang.text_for(:d1table, name, pTable.fields[0].capitalize, a[0], a[1], a[2], a[3])
        q.good="TRUE"
        q.write_to_file @file		
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
        @num+=1
        q.init
        q.set_boolean
        q.name="#{name}-#{@num.to_s}-d2table-#{pTable.name}"
        q.text=@lang.text_for(:d1table, name, pTable.fields[0].capitalize, a[0], a[1], a[2], a[3])
        q.good="FALSE"
        q.write_to_file @file		
	  end
	end
	
	if pTable.sequence? and pList1.count>3
	
	  a=0..(pList1.count-4)
	  a.each_entry do |i|
        #Question type <d3sequence>: items are part of a sequence
        @num+=1
        q.init
        q.set_match
        q.name="#{name}-#{@num.to_s}-d3sequence-#{pTable.name}"
        q.text=@lang.text_for(:d3sequence, name, pTable.fields[0].capitalize, pTable.sequence )
        q.matching << [ pList1[i+0][:data][0], '1º' ]
        q.matching << [ pList1[i+1][:data][0], '2º' ]
        q.matching << [ pList1[i+2][:data][0], '3º' ]
        q.matching << [ pList1[i+3][:data][0], '4º' ]
        q.write_to_file @file

        #Question type <d4sequence>: items are part of a reverse sequence
        @num+=1
        q.init
        q.set_match
        q.name="#{name}-#{@num.to_s}-d4sequence-#{pTable.name}"
        q.text=@lang.text_for(:d4sequence, name, pTable.fields[0].capitalize, pTable.sequence )
        q.matching << [ pList1[i+3][:data][0], '1º' ]
        q.matching << [ pList1[i+2][:data][0], '2º' ]
        q.matching << [ pList1[i+1][:data][0], '3º' ]
        q.matching << [ pList1[i+0][:data][0], '4º' ]
        q.write_to_file @file
      end
	end
  end
	
end
