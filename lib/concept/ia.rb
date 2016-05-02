# encoding: utf-8

require_relative 'ia_calculate'
require_relative 'ia_sequence'
require_relative 'ia_table1field'
require_relative 'ia_texts'

module IA
  include IA_calculate
  include IA_sequence
  include IA_table1field
  include IA_texts

  def process_texts	
    q=Question.new
    #for every <text> do this
    texts.each do |t|
      s=Set.new [name, @lang.text_for(:none)]
      neighbors.each { |n| s.add n[:concept].name } 
      a=s.to_a
      
      #Question type <a1desc>: choose between 4 options
      if s.count>3 then
        @num+=1
        q.init
        q.set_choice
        q.name="#{name}-#{@num.to_s}-a1desc"
        q.text=@lang.text_for(:a1desc,t)
        q.good=name
        q.bads << @lang.text_for(:none)
        q.bads << a[2]
        q.bads << a[3]
        q.write_to_file @file
      end
			
      s.delete(name)
      a=s.to_a
			
      #Question type <a2desc>: choose between 4 options
      if s.count>3 then
        @num+=1
        q.init
        q.set_choice
        q.name="#{name}-#{@num.to_s}-a2desc"
        q.text=@lang.text_for(:a2desc,t)
        q.good=@lang.text_for(:none)
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        q.write_to_file @file
      end
			
      #Question type <a3desc>: boolean => TRUE
      @num+=1
      q.init
      q.set_boolean
      q.name="#{name}-#{@num.to_s}-a3desc"
      q.text=@lang.text_for(:a3desc,name,t)
      q.good="TRUE"
      q.write_to_file @file

      #Question type <a4desc>: boolean => FALSE
      if neighbors.count>0 then
        @num+=1
        q.init
        q.set_boolean
        q.name="#{name}-#{@num.to_s}-a4desc"
        q.text=@lang.text_for(:a4desc,neighbors[0][:concept].name,t)
        q.good="FALSE"
        q.write_to_file @file
      end
			
      #Question type <a5desc>: hidden name questions
      @num+=1
      q.init
      q.set_short
      q.name="#{name}-#{@num.to_s}-a5desc"
      q.text=@lang.text_for(:a5desc, @lang.hide_text(name), t )
      q.shorts << name
      q.shorts << name.gsub("-"," ").gsub("_"," ")
      q.write_to_file @file

      #Question type <a6match>: filtered text questions
      filtered=@lang.text_with_connectors(t)
      if filtered[:words].size>=4 then
        @num+=1
        q.init
        q.set_match
        q.name="#{name}-#{@num.to_s}-a6match"
				
        indexes=Set.new
        words=filtered[:words]
        while indexes.size<4 
          i=rand(filtered[:words].size)					
          flag=true
          flag=false if words[i].include?("[") or words[i].include?("]") or words[i].include?("(") or words[i].include?(")") or words[i].include?("\"")
          indexes << i if flag
        end
        indexes=indexes.to_a
				
        s=@lang.build_text_from_filtered( filtered, indexes )
        q.text=@lang.text_for(:a6match, name , s)
        indexes.each { |value| q.matching << [ filtered[:words][value][:word].downcase, value.to_s ] }
        q.write_to_file @file				
      end
    end
  end

	def process_table_match(pTable, pList1, pList2)
		return if pTable.fields.count<2
		if pTable.fields.count>1 then
			process_table_match2fields(pTable, pList1, pList2, 0, 1)
		elsif pTable.fields.count>2 then
			process_table_match2fields(pTable, pList1, pList2, 0, 2)
			process_table_match2fields(pTable, pList1, pList2, 1, 2)
		elsif pTable.fields.count>3 then
			process_table_match2fields(pTable, pList1, pList2, 0, 3)
			process_table_match2fields(pTable, pList1, pList2, 1, 3)
			process_table_match2fields(pTable, pList1, pList2, 2, 3)
		end
	end
	
  def process_table_match2fields(pTable, pList1, pList2, pIndex1, pIndex2)
    q=Question.new

    if pList1.count>3 then
      #Question type <b1match>: match items from the same table
      @num+=1
      q.init
      q.set_match
      q.name="#{name}-#{@num.to_s}-b1match-#{pTable.name}"
      q.text=@lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
      q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
      q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
      q.matching << [ pList1[3][:data][pIndex1], pList1[3][:data][pIndex2] ]
      q.write_to_file @file
      
      #Question type <b1match>: match 3 items from table-A and 1 item with error
      @num+=1
      q.init
      q.set_match
      q.name="#{name}-#{@num.to_s}-b1match-#{pTable.name}"
      q.text=@lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
      q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
      q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
      q.matching << [ @lang.do_mistake_to(pList1[3][:data][pIndex1]), @lang.text_for(:error) ]
      q.write_to_file @file
      
    end

    if pList1.count>7 then
      @num+=1
      q.init
      q.set_match
      q.name="#{name}-#{@num.to_s}-b1match-#{pTable.name}"
      q.text=@lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[4][:data][pIndex1], pList1[4][:data][pIndex2] ]
      q.matching << [ pList1[5][:data][pIndex1], pList1[5][:data][pIndex2] ]
      q.matching << [ pList1[6][:data][pIndex1], pList1[6][:data][pIndex2] ]
      q.matching << [ pList1[7][:data][pIndex1], pList1[7][:data][pIndex2] ]
      q.write_to_file @file
    end

    if pList1.count>11 then
      @num+=1
      q.init
      q.set_match
      q.name="#{name}-#{@num.to_s}-b1match-#{pTable.name}"
      q.text=@lang.text_for(:b1match, name, pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize )
      q.matching << [ pList1[8][:data][pIndex1], pList1[8][:data][pIndex2] ]
      q.matching << [ pList1[9][:data][pIndex1], pList1[9][:data][pIndex2] ]
      q.matching << [ pList1[10][:data][pIndex1], pList1[10][:data][pIndex2] ]
      q.matching << [ pList1[11][:data][pIndex1], pList1[11][:data][pIndex2] ]
      q.write_to_file @file
    end
    
    if pList1.count>2 and pList2.count>0 then
      s=Set.new
      pList1.each { |i| s.add( i[:data][pIndex1]+"<=>"+i[:data][pIndex2] ) }
      s.add( pList2[0][:data][pIndex1]+"<=>"+pList2[0][:data][pIndex2] ) 
      a=s.to_a

      #Question type <b2match>: 3 items from table-A, and 1 item from table-B
      if s.count>3 then
        @num+=1
        q.init
        q.set_match
        q.name="#{name}-#{@num.to_s}-b2match-#{pTable.name}"
        q.text=@lang.text_for(:b2match, name , pTable.fields[pIndex1].capitalize, pTable.fields[pIndex2].capitalize) 
        q.matching << [ pList1[0][:data][pIndex1], pList1[0][:data][pIndex2] ]
        q.matching << [ pList1[1][:data][pIndex1], pList1[1][:data][pIndex2] ]
        q.matching << [ pList1[2][:data][pIndex1], pList1[2][:data][pIndex2] ]
        q.matching << [ pList2[0][:data][pIndex1], @lang.text_for(:error) ]
        q.write_to_file @file
      end			
    end
  end
	
  def process_tableXfields(pTable, pRow, pList)
    if pTable.fields.count>1 then
      process_table2fields(pTable, pRow, pList, 0, 1)
    elsif pTable.fields.count>2 then
      process_table2fields(pTable, pRow, pList, 0, 2)
      process_table2fields(pTable, pRow, pList, 1, 2)
    elsif pTable.fields.count>3 then
      process_table2fields(pTable, pRow, pList, 0, 3)
      process_table2fields(pTable, pRow, pList, 1, 3)
      process_table2fields(pTable, pRow, pList, 2, 3)
    end
  end
	
  def process_table2fields(lTable, lRow, pList, pCol1, pCol2)
		q=Question.new	

		#create gift questions	
		s=Set.new [ lRow[:data][0] , @lang.text_for(:none) ]
		pList.each { |i| s.add( i[:data][0] ) }
		a=s.to_a
		
		if s.count>3 then		
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}-c1table-#{lTable.name}"
			q.text=@lang.text_for(:c1table, name, lTable.fields[0].capitalize, lTable.fields[1].capitalize, lRow[:data][1])
			q.good=lRow[:data][0]
			q.bads << @lang.text_for(:none)
			q.bads << a[2]
			q.bads << a[3]
			q.write_to_file @file		
		end
				
		s=Set.new [ lRow[:data][0], @lang.text_for(:none) ]
		pList.each { |i| s.add( i[:data][0] ) }
		a=s.to_a

		if s.count>4 then
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}-c2table-#{lTable.name}"
			q.text=@lang.text_for(:c2table, name, lTable.fields[0].capitalize, lTable.fields[1].capitalize, lRow[:data][1])
			q.good=@lang.text_for(:none)
			q.bads << a[2]
			q.bads << a[3]
			q.bads << a[4]
			q.write_to_file @file
		end

		s=Set.new [ lRow[:data][1], @lang.text_for(:none) ]
		pList.each { |i| s.add( i[:data][1] ) }
		a=s.to_a

		if s.count>3 then			
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}-c3table-#{lTable.name}"
			q.text=@lang.text_for(:c3table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize)
			q.good=a[0]
			q.bads << @lang.text_for(:none)
			q.bads << a[2]
			q.bads << a[3]
			q.write_to_file @file		
		end
		
		s=Set.new [ lRow[:data][1], @lang.text_for(:none) ]
		pList.each { |i| s.add( i[:data][1] ) }
		a=s.to_a

		if s.count>4 then			
			@num+=1
			q.init
			q.name="#{name}-#{@num.to_s}-c4table-#{lTable.name}"
			q.text=@lang.text_for(:c4table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize)
			q.good=@lang.text_for(:none)
			q.bads << a[2]
			q.bads << a[3]
			q.bads << a[4]
			q.write_to_file @file
		end

		@num+=1
		q.init
		q.set_boolean
		q.name="#{name}-#{@num.to_s}c5table-#{lTable.name}"
		q.text=@lang.text_for(:c5table, name, lTable.fields[0].capitalize, lRow[:data][0] ,lTable.fields[1].capitalize, lRow[:data][1] )
		q.good="TRUE"
		q.write_to_file @file

		s=Set.new [ lRow[:data][1] ]
		pList.each { |i| s.add( i[:data][1] ) }
		a=s.to_a

		if s.count>1 then		
			@num+=1
			q.init
			q.set_boolean
			q.name="#{name}-#{@num.to_s}-c6table-#{lTable.name}"
			q.text=@lang.text_for(:c6table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize, a[1] )
			q.good="FALSE"
			q.write_to_file @file
		end
		
		s=Set.new [ lRow[:data][0] ]
		pList.each { |i| s.add( i[:data][0] ) }
		a=s.to_a

		if s.count>1 then
			@num+=1
			q.init
			q.set_boolean
			q.name="#{name}-#{@num.to_s}c7table-#{lTable.name}"
			q.text=@lang.text_for(:c7table, name, lTable.fields[0].capitalize, a[1], lTable.fields[1].capitalize, lRow[:data][1] )
			q.good="FALSE"
			q.write_to_file @file
		end
	end
end
