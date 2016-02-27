# encoding: utf-8

module IA_sequence

  def process_sequence(pTable, pList1, pList2)
    return if not ( pTable.fields.count==1 and pTable.sequence?)
 
    q=Question.new
    
	if pList1.count>3	
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
