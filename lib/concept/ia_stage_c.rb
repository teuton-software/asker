# encoding: utf-8

module IA_stage_c
  #range c1-c9
  
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

    # Using the column #0
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

    # Using the column #1
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

    # Boolean association TRUE
    @num+=1
    q.init
    q.set_boolean
    q.name="#{name}-#{@num.to_s}c5table-#{lTable.name}"
    q.text=@lang.text_for(:c5table, name, lTable.fields[0].capitalize, lRow[:data][0] ,lTable.fields[1].capitalize, lRow[:data][1] )
    q.good="TRUE"
    q.write_to_file @file

    # Boolean association FALSE
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

    # Short answer with column #0, 1 word
    if @lang.count_words(lRow[:data][0])==1 then
      @num+=1
      q.init
      q.set_short
      q.name="#{name}-#{@num.to_s}c8table-#{lTable.name}"
      q.text=@lang.text_for(:c8table, name, lTable.fields[1].capitalize, lRow[:data][1], lTable.fields[0].capitalize)
      q.shorts << lRow[:data][0]
      q.shorts << lRow[:data][0].gsub("-"," ").gsub("_"," ")
      q.write_to_file @file
    elsif @lang.count_words(lRow[:data][0])==2 then
      @num+=1
      q.init
      q.set_short
      q.name="#{name}-#{@num.to_s}c9table-#{lTable.name}"
      q.text=@lang.text_for(:c9table, name, lTable.fields[1].capitalize, lRow[:data][1], lTable.fields[0].capitalize, "[#{@lang.hide_text(lRow[:data][0])}]", @lang.count_words(lRow[:data][0]) )
      q.shorts << lRow[:data][0]
      q.shorts << lRow[:data][0].gsub("-"," ").gsub("_"," ")
      q.write_to_file @file
    end

    # Short answer with column #1, 1 word
    if @lang.count_words(lRow[:data][1])==1 then
      @num+=1
      q.init
      q.set_short
      q.name="#{name}-#{@num.to_s}c8table-#{lTable.name}"
      q.text=@lang.text_for(:c8table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize)
      q.shorts << lRow[:data][1]
      q.shorts << lRow[:data][1].gsub("-"," ").gsub("_"," ")
      q.write_to_file @file
    elsif @lang.count_words(lRow[:data][1])==2 then
      @num+=1
      q.init
      q.set_short
      q.name="#{name}-#{@num.to_s}c9table-#{lTable.name}"
      q.text=@lang.text_for(:c9table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize, "[#{@lang.hide_text(lRow[:data][1])}]", @lang.count_words(lRow[:data][1]) )
      q.shorts << lRow[:data][1]
      q.shorts << lRow[:data][1].gsub("-"," ").gsub("_"," ")
      q.write_to_file @file
    end

  end
end
