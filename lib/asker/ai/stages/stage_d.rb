# encoding: utf-8

require 'set'

require_relative 'base_stage'
require_relative '../question'

class StageD < BaseStage
  # range d1-d4

  def run
    # Stage D: process every definition, I mean every <def> tag
    questions = []
    return questions unless type == 'text'

    # for every <text> do this
    texts.each do |t|
      s=Set.new [name(:raw), lang.text_for(:none)]
      neighbors.each { |n| s.add n[:concept].name(:decorated) }
      a=s.to_a

      # Question choose between 4 options
      if s.count > 3
        q=Question.new(:choice)
        q.name="#{name(:id)}-#{num}-d1choose"
        q.text=random_image_for(name(:raw)) + lang.text_for(:d1,t)
        q.good=name(:raw)
        q.bads << lang.text_for(:none)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      #Question choose between 4 options, good none (Syntax error)
      if s.count>3 and type=="text" then
        q=Question.new(:choice)
        q.name="#{name(:id)}-#{num}-d1none-misspelled"
        q.text=random_image_for(name(:raw)) + lang.text_for(:d1,t)
        q.good = lang.text_for(:none)
        q.bads << lang.do_mistake_to(name(:raw))
        q.bads << a[2]
        q.bads << a[3]
        q.feedback="Option misspelled!: #{name(:raw)}"
        questions << q
      end

      s.delete(name(:raw))
      a=s.to_a

      #Question choose between 4 options, good none
      if s.count>3 then
        q = Question.new(:choice)
        q.name="#{name(:id)}-#{num}-d1none"
        q.text=random_image_for(name(:raw)) + lang.text_for(:d1,t)
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
      q.name="#{name(:id)}-#{num}-d2def-mispelled"
      q.text=random_image_for(name(:raw)) + lang.text_for(:d2,name(:decorated), lang.do_mistake_to(t) )
      q.good=lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      q.bads << lang.text_for(:false)
      q.feedback="Definition text mispelled!: #{t}"
      questions << q

      if type=="text"
        q = Question.new(:choice)
        q.name="#{name(:id)}-#{num}-d2name-mispelled"
        q.text=random_image_for(name(:raw)) + lang.text_for(:d2, lang.do_mistake_to(name(:raw)), t)
        q.good=lang.text_for(:misspelling)
        q.bads << lang.text_for(:true)
        q.bads << lang.text_for(:false)
        q.feedback="Concept name mispelled!: #{name(:raw)}"
        questions << q
      end

      q = Question.new(:choice)
      q.name="#{name(:id)}-#{num}-d2true"
      q.text=random_image_for(name(:raw)) + lang.text_for(:d2, name(:raw), t )
      q.good =  lang.text_for(:true)
      q.bads << lang.text_for(:misspelling)
      q.bads << lang.text_for(:false)
      questions << q

      if a.size>1 then
        q = Question.new(:choice)
        q.name="#{name(:id)}-#{num}-d2false-misspelled"
        q.text=random_image_for(name(:raw)) + lang.text_for(:d2, a[1], t)
        q.good =  lang.text_for(:false)
        q.bads << lang.text_for(:misspelling)
        q.bads << lang.text_for(:true)
        questions << q
      end

      #Question type <a4desc>: boolean => FALSE
      #if neighbors.count>0 then
      #  q = Question.new(:boolean)
      #  q.name="#{name}-#{num}-d2false"
      #  q.text=random_image_for(name) + lang.text_for(:d2, neighbors[0][:concept].name, t)
      #  q.good="FALSE"
      #  questions << q
      #end

      if type=="text"
        #Question hidden name questions
        q = Question.new(:short)
        q.name="#{name(:id)}-#{num}-d3hidden"
        q.text=random_image_for(name(:raw)) + lang.text_for(:d3, lang.hide_text(name(:raw)), t )
        q.shorts << name(:raw)
        q.shorts << name(:raw).gsub("-"," ").gsub("_"," ")
        names.each do |n|
          q.shorts << n if n!=name
        end
        questions << q
      end

#      indexes = []
#      exclude = ["[", "]", "(", ")", "\"" ]
#      filtered[:words].each_with_index do |item,index|
#        flag=true
#        exclude.each { |e| flag=false if (item[:word].include?(e)) }
#        indexes << index if flag
#      end

      #Question filtered text questions
      filtered=lang.text_with_connectors(t)
      indexes = filtered[:indexes]

      groups = (indexes.combination(4).to_a).shuffle
      max    = (indexes.size/4).to_i
      groups[0,max].each do |e|
        e.sort!
        q = Question.new(:match)
        q.shuffle_off
        q.name = "#{name}-#{num}-d4filtered"
        s = lang.build_text_from_filtered( filtered, e)
        q.text = random_image_for(name(:raw)) + lang.text_for(:d4, name(:raw) , s)
        e.each_with_index do |value,index|
          q.matching << [ (index+1).to_s, filtered[:words][value][:word].downcase ]
        end
        questions << q
      end
    end

    return questions
  end

end
