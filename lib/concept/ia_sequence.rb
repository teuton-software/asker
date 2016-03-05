# encoding: utf-8

module IA_sequence

  def process_sequence(pTable, pList1, pList2)
    return if not ( pTable.fields.count==1 and pTable.sequence?)
 
    q=Question.new
    
    #TODO
    #items=[]
    #pList1.each_with_index { |i,j| items<<[ i[:data][0], j] }
    #puts Rainbow(items).blue.bright
    
    #Question type <d3sequence>: items are part of a sequence
	if pList1.count>3 and pTable.sequence[0]!=""	
	  a=0..(pList1.count-4)
	  a.each_entry do |i|
        @num+=1
        q.init
        q.set_match
        q.name="#{name}-#{@num.to_s}-d3sequence-#{pTable.name}"
        q.text=@lang.text_for(:d3sequence, name, pTable.fields[0].capitalize, pTable.sequence[0] )
        q.matching << [ pList1[i+0][:data][0], '1º' ]
        q.matching << [ pList1[i+1][:data][0], '2º' ]
        q.matching << [ pList1[i+2][:data][0], '3º' ]
        q.matching << [ pList1[i+3][:data][0], '4º' ]
        q.write_to_file @file
      end
    end
       
    #Question type <d4sequence>: items are part of a reverse sequence
    if pList1.count>3 and pTable.sequence.size>1
	  a=0..(pList1.count-4)
	  a.each_entry do |i|
        @num+=1
        q.init
        q.set_match
        q.name="#{name}-#{@num.to_s}-d4sequence-#{pTable.name}"
        q.text=@lang.text_for(:d4sequence, name, pTable.fields[0].capitalize, pTable.sequence[1] )
        q.matching << [ pList1[i+3][:data][0], '1º' ]
        q.matching << [ pList1[i+2][:data][0], '2º' ]
        q.matching << [ pList1[i+1][:data][0], '3º' ]
        q.matching << [ pList1[i+0][:data][0], '4º' ]
        q.write_to_file @file
      end
	end
  end
	
end
