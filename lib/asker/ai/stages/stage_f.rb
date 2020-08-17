
require_relative 'base_stage'
require_relative '../question'

# StageF: process tables with 1 field
class StageF < BaseStage
  def run(table, list1, list2)
    # process_table1field
    questions = []
    return questions if table.fields.count>1

    questions += run_only_this_concept(table, list1)
    questions += run_with_other_concepts(table, list1, list2)

    questions
  end

private

  def run_only_this_concept(table, list1)
    questions = []
    s1 = Set.new #Set of rows from this concept
    list1.each { |item| s1 << item[:data][0] }
    a1 = s1.to_a
    a1.shuffle!

    if a1.size > 3
      a1.each_cons(4) do |e1,e2,e3,e4|
        e = [ e1, e2, e3, e4 ]
        questions += make_questions_with(e, table)

        #Question filtered text
        e = [ e1, e2, e3, e4 ]
        e.shuffle!
        t = "(a) #{e[0]}, (b) #{e[1]}, (c) #{e[2]}, (d) #{e[3]}"
        filtered=lang.text_with_connectors(t)
        indexes = filtered[:indexes]

        groups = (indexes.combination(4).to_a).shuffle
        max    = (indexes.size/4).to_i
        groups[0, max].each do |i|
          i.sort!
          q = Question.new(:match)
          q.shuffle_off
          q.name = "#{name}-#{num}-f3filtered"
          s = lang.build_text_from_filtered(filtered, i)
          q.text = random_image_for(name(:raw))
          q.text += lang.text_for(:f3, name(:decorated), table.fields[0].capitalize, s)
          i.each_with_index do |value,index|
            q.matching << [(index + 1).to_s, filtered[:words][value][:word].downcase]
          end
          questions << q
        end
      end
    else
      # Execute this block when "a1.size <=3"
      questions += make_questions_with(a1.dup, table)
    end
    questions
  end

  def make_questions_with(e, table)
    questions = []

    e.shuffle!
    q = Question.new(:choice)
    q.name = "#{name(:id)}-#{num}-f1true#{e.size}-#{table.name}"
    q.text = random_image_for(name(:raw))
    q.text += lang.text_for(:f1, name(:decorated), table.fields[0].capitalize, e.join('</li><li>'))
    q.good =  lang.text_for(:true)
    q.bads << lang.text_for(:misspelling)
    q.bads << lang.text_for(:false)

    if type == 'text'
      e.shuffle!
      q = Question.new(:short)
      q.name = "#{name(:id)}-#{num}-f1short#{e.size}-#{table.name}"
      q.text = random_image_for(name(:raw))
      q.text += lang.text_for(:f1, lang.hide_text(name(:raw)), table.fields[0].capitalize, e.join('</li><li>'))
      q.shorts << name(:raw)
      q.shorts << name(:raw).tr('-_', ' ')
      questions << q

      e.shuffle!
      save = e[0]
      e[0] = lang.do_mistake_to(e[0])
      q = Question.new(:choice)
      q.name = "#{name(:id)}-#{num}-f1name-misspelled#{e.size}-#{table.name}"
      q.text = random_image_for(name(:raw))
      q.text += lang.text_for(:f1, lang.do_mistake_to(name(:decorated)), table.fields[0].capitalize, e.join('</li><li>'))
      q.good =  lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      q.bads << lang.text_for(:false)
      q.feedback = "Concept name #{name(:raw)} misspelled!"
      e[0] = save
      questions << q
    end

    e.shuffle!
    save = e[0]
    e[0] = lang.do_mistake_to(e[0])
    q = Question.new(:choice)
    q.name = "#{name(:id)}-#{num}-f1true-misspelled#{e.size}-#{table.name}"
    q.text = random_image_for(name(:raw))
    q.text += lang.text_for(:f1, name(:decorated), table.fields[0].capitalize, e.join('</li><li>'))
    q.good =  lang.text_for(:misspelling)
    q.bads << lang.text_for(:true)
    q.bads << lang.text_for(:false)
    q.feedback = "Text #{save} mispelled!"
    e[0] = save
    questions << q
  end

  def run_with_other_concepts(table, list1, list2)
    questions = []

    s1 = Set.new # Set of rows from this concept
    list1.each { |item| s1 << item[:data][0] }
    a1 = s1.to_a
    a1.shuffle!

    s2 = Set.new # Set of rows from other concepts
    list2.each { |item| s2 << item[:data][0] }
    a2 = s2.to_a
    a2 -= a1

    return questions if a1.size <= 2 || a2.empty?

    a1.each_cons(3) do |e1, e2, e3|
      f4 = a2.shuffle![0]
      e = [e1, e2, e3, f4]
      e.shuffle!
      q = Question.new(:choice)
      q.name = "#{name(:id)}-#{num}-f1false-#{table.name}"
      q.text = random_image_for(name(:raw))
      q.text += lang.text_for(:f1, name(:decorated), table.fields[0].capitalize, e.join('</li><li>'))
      q.good =  lang.text_for(:false)
      q.bads << lang.text_for(:misspelling)
      q.bads << lang.text_for(:true)
      questions << q

      f4 = a2.shuffle![0]
      q = Question.new(:choice)
      q.name = "#{name(:id)}-#{num}-f2outsider-#{table.name}"
      q.text = random_image_for(name(:raw))
      q.text += lang.text_for(:f2, name(:decorated), table.fields[0].capitalize)
      q.good =  f4
      q.bads << e1
      q.bads << e2
      q.bads << e3
      questions << q
    end

    questions
  end
end
