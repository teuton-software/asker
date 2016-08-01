# encoding: utf-8

module IA_stage_a
  #range a1-a6
  #a7???

  def run_stage_a
    #Stage A: process every definition, I mean every <def> tag
    questions=[]

    #for every <text> do this
    texts.each do |t|
      s=Set.new [name, lang.text_for(:none)]
      neighbors.each { |n| s.add n[:concept].name }
      a=s.to_a

      #Question type <a1desc>: choose between 4 options
      if s.count>3 then
        q=Question.new(:choice)
        q.name="#{name}-#{num}-a1desc"
        q.text=lang.text_for(:a1desc,t)
        q.good=name
        q.bads << lang.text_for(:none)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question type <a2desc>: choose between 4 options, good none (Sintax error)
      if s.count>3 then
        q=Question.new(:choice)
        q.name="#{name}-#{num}-a2desc"
        q.text=lang.text_for(:a1desc,t)
        q.good = lang.text_for(:none)
        q.bads << lang.do_mistake_to(name)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      s.delete(name)
      a=s.to_a

      #Question type <a2desc>: choose between 4 options, good none
      if s.count>3 then
        q = Question.new(:choice)
        q.name="#{name}-#{num}-a2desc"
        q.text=lang.text_for(:a2desc,t)
        q.good=lang.text_for(:none)
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question type <a3desc>: boolean => TRUE
      q = Question.new(:boolean)
      q.name="#{name}-#{num}-a3desc"
      q.text=lang.text_for(:a3desc,name,t)
      q.good="TRUE"
      questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-a3desc"
      q.text=lang.text_for(:a3desc,name, lang.do_mistake_to(t) )
      q.good=lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      q.bads << lang.text_for(:false)
      questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-a3desc"
      q.text=lang.text_for(:a3desc, lang.do_mistake_to(name), t)
      q.good=lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      q.bads << lang.text_for(:false)
      questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-a3desc"
      q.text=lang.text_for(:a3desc,name, t )
      q.good = lang.text_for(:true)
      q.bads << lang.text_for(:misspelling)
      q.bads << lang.text_for(:false)
      questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-a3desc"
      q.text=lang.text_for(:a3desc, a[1], t)
      q.good = lang.text_for(:false)
      q.bads << lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      questions << q

      #Question type <a4desc>: boolean => FALSE
      if neighbors.count>0 then
        q = Question.new(:boolean)
        q.name="#{name}-#{num}-a4desc"
        q.text=lang.text_for(:a4desc,neighbors[0][:concept].name,t)
        q.good="FALSE"
        questions << q
      end

      #Question type <a5desc>: hidden name questions
      q = Question.new(:short)
      q.name="#{name}-#{num}-a5desc"
      q.text=lang.text_for(:a5desc, lang.hide_text(name), t )
      q.shorts << name
      q.shorts << name.gsub("-"," ").gsub("_"," ")
      questions << q

      #Question type <a6match>: filtered text questions
      filtered=lang.text_with_connectors(t)
      if filtered[:words].size>=4 then
        q = Question.new
        q.set_match
        q.name="#{name}-#{num}-a6match"

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
