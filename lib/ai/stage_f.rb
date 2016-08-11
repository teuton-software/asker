# encoding: utf-8

require_relative 'base_stage'

class StageF < BaseStage

  def run(pTable, pList1, pList2)
    #process_table1field
    questions = []
    return questions if pTable.fields.count>1

    s1 = Set.new
    pList1.each { |item| s1 << item[:data][0] }
    a1=s1.to_a
    a1.shuffle!

    if a1.size>3 then
      a1.each_cons(4) do |e1,e2,e3,e4|
        q=Question.new(:boolean)
        q.name="#{name}-#{num.to_s}-f1table-#{pTable.name}"
        q.text=lang.text_for(:f1, name, pTable.fields[0].capitalize, e1, e2, e3, e4)
        q.good="TRUE"
        questions << q
      end
    end

    s2 = Set.new
    pList2.each { |item| s2 << item[:data][0] }
    a2 = s2.to_a

    if a1.size>2 and a2.size>0 then
      a1.each_cons(3) do |e1,e2,e3|
        f = a2.shuffle![0]
        h = [ e1, e2, e3, f]

        q=Question.new(:boolean)
        q.name="#{name}-#{num.to_s}-f1table-#{pTable.name}"
        q.text=lang.text_for(:f1, name, pTable.fields[0].capitalize, h[0], h[1], h[2], h[3])
        q.good="FALSE"
        questions << q
      end
    end

    return questions
  end

end
