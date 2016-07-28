# encoding: utf-8

module IA_texts

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
      q.text=@lang.text_for(:a5desc, hiden_name, t )
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

=begin
      #Question type <a7desc>: concept name with mistakes
      @num+=1
      q.init
      q.set_choice
      q.name="#{name}-#{@num.to_s}-a7desc"
      q.text=@lang.text_for(:a7desc,t)
      q.good=name
      q.bads << a[1]
      q.bads << a[2]
      q.bads << a[3]
      q.write_to_file @file
      
      if s.count>2
        @num+=1
        q.init
        q.set_choice
        q.name="#{name}-#{@num.to_s}-a7desc"
        q.text=@lang.text_for(:a7desc,t)
        q.good=a[0]
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        q.write_to_file @file
      @lang.text_for(:none)
      q.text=@lang.text_for(:a7desc,@lang.do_mistake_to(name),t)
      end
=end
    end
  end

end
