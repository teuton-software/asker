# encoding: utf-8

require_relative 'base_stage'
require_relative '../question'

class StageD < BaseStage
  #range d1-d4

  def run
    #Stage D: process every definition, I mean every <def> tag
    questions=[]

    #for every <text> do this
    texts.each do |t|
      s=Set.new [name, lang.text_for(:none)]
      neighbors.each { |n| s.add n[:concept].name }
      a=s.to_a

      #Question choose between 4 options
      if s.count>3 then
        q=Question.new(:choice)
        q.name="#{name}-#{num}-d1choose"
        q.text=random_image_for(name) + lang.text_for(:d1,t)
        q.good=name
        q.bads << lang.text_for(:none)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question choose between 4 options, good none (Syntax error)
      if s.count>3 then
        q=Question.new(:choice)
        q.name="#{name}-#{num}-d1none"
        q.text=random_image_for(name) + lang.text_for(:d1,t)
        q.good = lang.text_for(:none)
        q.bads << lang.do_mistake_to(name)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      s.delete(name)
      a=s.to_a

      #Question choose between 4 options, good none
      if s.count>3 then
        q = Question.new(:choice)
        q.name="#{name}-#{num}-d1none"
        q.text=random_image_for(name) + lang.text_for(:d1,t)
        q.good=lang.text_for(:none)
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question boolean => TRUE
      #q = Question.new(:boolean)
      #q.name="#{name}-#{num}-d2true"
      #q.text=random_image_for(name) + lang.text_for(:d2,name,t)
      #q.good="TRUE"
      #questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-d2def-mispelled"
      q.text=random_image_for(name) + lang.text_for(:d2,name, lang.do_mistake_to(t) )
      q.good=lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      q.bads << lang.text_for(:false)
      questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-d2name-mispelled"
      q.text=random_image_for(name) + lang.text_for(:d2, lang.do_mistake_to(name), t)
      q.good=lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      q.bads << lang.text_for(:false)
      questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-d2true"
      q.text=random_image_for(name) + lang.text_for(:d2,name, t )
      q.good = lang.text_for(:true)
      q.bads << lang.text_for(:misspelling)
      q.bads << lang.text_for(:false)
      questions << q

      q = Question.new(:choice)
      q.name="#{name}-#{num}-d2false"
      q.text=random_image_for(name) + lang.text_for(:d2, a[1], t)
      q.good = lang.text_for(:false)
      q.bads << lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      questions << q

      #Question type <a4desc>: boolean => FALSE
      #if neighbors.count>0 then
      #  q = Question.new(:boolean)
      #  q.name="#{name}-#{num}-d2false"
      #  q.text=random_image_for(name) + lang.text_for(:d2, neighbors[0][:concept].name, t)
      #  q.good="FALSE"
      #  questions << q
      #end

      #Question hidden name questions
      q = Question.new(:short)
      q.name="#{name}-#{num}-d3hidden"
      q.text=random_image_for(name) + lang.text_for(:d3, lang.hide_text(name), t )
      q.shorts << name
      q.shorts << name.gsub("-"," ").gsub("_"," ")
      questions << q

      #Question filtered text questions
      filtered=lang.text_with_connectors(t)
      if filtered[:words].size>=4 then
        q = Question.new(:match)
        q.name="#{name}-#{num}-d4filtered"

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
        q.text=random_image_for(name) + lang.text_for(:d4, name , s)
        indexes.each { |value| q.matching << [ filtered[:words][value][:word].downcase, value.to_s ] }
        questions << q
      end
    end
    return questions
  end

end
