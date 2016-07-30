# encoding: utf-8

module IA_stage_a
  #range a1-a6
  #a7???

  def run_stage_a
    #process_texts
    questions=[]

    #for every <text> do this
    texts.each do |t|
      s=Set.new [name, lang.text_for(:none)]
      neighbors.each { |n| s.add n[:concept].name }
      a=s.to_a

      #Question type <a1desc>: choose between 4 options
      if s.count>3 then
        q=Question.new
        q.set_choice
        q.name="#{name}-#{num.to_s}-a1desc"
        q.text=lang.text_for(:a1desc,t)
        q.good=name
        q.bads << lang.text_for(:none)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      s.delete(name)
      a=s.to_a

      #Question type <a2desc>: choose between 4 options, good none
      if s.count>3 then
        q = Question.new
        q.set_choice
        q.name="#{name}-#{num.to_s}-a2desc"
        q.text=lang.text_for(:a2desc,t)
        q.good=lang.text_for(:none)
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question type <a3desc>: boolean => TRUE
      q = Question.new
      q.set_boolean
      q.name="#{name}-#{num.to_s}-a3desc"
      q.text=lang.text_for(:a3desc,name,t)
      q.good="TRUE"
      questions << q

      #Question type <a4desc>: boolean => FALSE
      if neighbors.count>0 then
        q = Question.new
        q.set_boolean
        q.name="#{name}-#{num.to_s}-a4desc"
        q.text=lang.text_for(:a4desc,neighbors[0][:concept].name,t)
        q.good="FALSE"
        questions << q
      end

      #Question type <a5desc>: hidden name questions
      q = Question.new
      q.set_short
      q.name="#{name}-#{num.to_s}-a5desc"
      q.text=lang.text_for(:a5desc, lang.hide_text(name), t )
      q.shorts << name
      q.shorts << name.gsub("-"," ").gsub("_"," ")
      questions << q

      #Question type <a6match>: filtered text questions
      filtered=lang.text_with_connectors(t)
      if filtered[:words].size>=4 then
        q = Question.new
        q.set_match
        q.name="#{name}-#{num.to_s}-a6match"

        indexes=Set.new
        words=filtered[:words]
        while indexes.size<4
          i=rand(filtered[:words].size)
          flag=true
          flag=false if words[i].include?("[") or words[i].include?("]") or words[i].include?("(") or words[i].include?(")") or words[i].include?("\"")
          indexes << i if flag
        end
        indexes=indexes.to_a

        s=lang.build_text_from_filtered( filtered, indexes )
        q.text=lang.text_for(:a6match, name , s)
        indexes.each { |value| q.matching << [ filtered[:words][value][:word].downcase, value.to_s ] }
        questions << q
      end
    end
    return questions
  end

end
