# encoding: utf-8

require_relative 'base_stage'
require_relative '../question'

class StageF < BaseStage

  def run(pTable, pList1, pList2)
    #process_table1field
    questions = []
    return questions if pTable.fields.count>1

    questions += run_only_this_concept(pTable, pList1, pList2)
    questions += run_with_other_concepts(pTable, pList1, pList2)

    return questions
  end

private

  def run_only_this_concept(pTable, pList1, pList2)
    questions =[]
    s1 = Set.new #Set of rows from this concept
    pList1.each { |item| s1 << item[:data][0] }
    a1=s1.to_a
    a1.shuffle!

    if a1.size>3 then
      a1.each_cons(4) do |e1,e2,e3,e4|
        e = [ e1, e2, e3, e4 ]
        e.shuffle!
        q=Question.new(:choice)
        q.name="#{name(:id)}-#{num.to_s}-f1true-#{pTable.name}"
        q.text = random_image_for(name(:raw)) + lang.text_for(:f1, name(:decorated), pTable.fields[0].capitalize, e.join("</li><li>") )
        q.good =  lang.text_for(:true)
        q.bads << lang.text_for(:misspelling)
        q.bads << lang.text_for(:false)
        questions << q

        if type=="text" then
          e = [ e1, e2, e3, e4 ]
          e.shuffle!
          q=Question.new(:short)
          q.name="#{name(:id)}-#{num.to_s}-f1short-#{pTable.name}"
          q.text = random_image_for(name(:raw)) + lang.text_for(:f1, lang.hide_text(name(:raw)), pTable.fields[0].capitalize, e.join("</li><li>") )
          q.shorts << name(:raw)
          q.shorts << name(:raw).gsub("-"," ").gsub("_"," ")
          questions << q
        end

        if type=="text" then
          e = [ e1, e2, e3, e4 ]
          e.shuffle!
          e[0] = lang.do_mistake_to(e[0])
          q=Question.new(:choice)
          q.name="#{name(:id)}-#{num.to_s}-f1namemispelled-#{pTable.name}"
          q.text = random_image_for(name(:raw)) + lang.text_for(:f1, lang.do_mistake_to(name(:decorated)), pTable.fields[0].capitalize, e.join("</li><li>") )
          q.good =  lang.text_for(:misspelling)
          q.bads << lang.text_for(:true)
          q.bads << lang.text_for(:false)
          questions << q
        end

        e = [ e1, e2, e3, e4 ]
        e.shuffle!
        e[0] = lang.do_mistake_to(e[0])
        e.shuffle!
        q=Question.new(:choice)
        q.name="#{name(:id)}-#{num.to_s}-f1truemispelled-#{pTable.name}"
        q.text = random_image_for(name(:raw)) + lang.text_for(:f1, name(:decorated), pTable.fields[0].capitalize, e.join("</li><li>") )
        q.good =  lang.text_for(:misspelling)
        q.bads << lang.text_for(:true)
        q.bads << lang.text_for(:false)
        questions << q
      end
    end
    return questions
  end

  def run_with_other_concepts(pTable, pList1, pList2)
    questions = []

    s1 = Set.new #Set of rows from this concept
    pList1.each { |item| s1 << item[:data][0] }
    a1=s1.to_a
    a1.shuffle!

    s2 = Set.new #Set of rows from other concepts
    pList2.each { |item| s2 << item[:data][0] }
    a2 = s2.to_a
    a2 = a2 -a1

    if a1.size>2 and a2.size>0 then
      a1.each_cons(3) do |e1,e2,e3|

        f4 = a2.shuffle![0]
        e = [ e1, e2, e3, f4 ]
        e.shuffle!
        q=Question.new(:choice)
        q.name="#{name(:id)}-#{num.to_s}-f1false-#{pTable.name}"
        q.text = random_image_for(name(:raw)) + lang.text_for(:f1, name(:decorated), pTable.fields[0].capitalize, e.join("</li><li>"))
        q.good =  lang.text_for(:false)
        q.bads << lang.text_for(:misspelling)
        q.bads << lang.text_for(:true)
        questions << q

        f4 = a2.shuffle![0]
        q=Question.new(:choice)
        q.name="#{name(:id)}-#{num.to_s}-f2outsider-#{pTable.name}"
        q.text = random_image_for(name(:raw)) + lang.text_for(:f2, name(:decorated), pTable.fields[0].capitalize)
        q.good =  f4
        q.bads << e1
        q.bads << e2
        q.bads << e3
        questions << q
      end
    end

    return questions
  end

end
