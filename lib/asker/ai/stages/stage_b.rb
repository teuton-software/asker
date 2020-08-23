# encoding: utf-8

require 'set'

require_relative 'base_stage'
require_relative '../question'

class StageB < BaseStage
  # range b1

  ##
  # Process table data to generate match questions
  # @param table (Table)
  # @param list1 (Array) Rows that belong to this table
  # @param list2 (Array) List with similar rows (same table name) from the neighbours tables
  def run(table, list1, list2)
    questions = []
    return questions if table.fields.count < 2

    return questions unless type == 'text'

    if table.fields.count == 2
      questions += process_table_match2fields(table, list1, list2, 0, 1)
    elsif table.fields.count == 3
      questions += process_table_match2fields(table, list1, list2, 0, 1)
      questions += process_table_match2fields(table, list1, list2, 0, 2)
    elsif table.fields.count == 4
      questions += process_table_match2fields(table, list1, list2, 0, 1)
      questions += process_table_match2fields(table, list1, list2, 0, 2)
      questions += process_table_match2fields(table, list1, list2, 0, 3)
    end

    questions
  end

  ##
  # Process table data to generate match questions
  # @param table (Table)
  # @param list1 (Array) Rows that belong to this table
  # @param list2 (Array) List with similar rows (same table name) from the neighbours tables
  # @param index1 (Integer) Use this field number
  # @param index2 (Integer) Use this field number
  def process_table_match2fields(p_table, list1, list2, index1, index2)
    questions = []

    if list1.count > 3
      list1.each_cons(4) do |e1,e2,e3,e4|
        e = [ e1, e2, e3, e4 ]

        # Question type <b1match>: match 4 items from the same table
        e.shuffle!
        q = Question.new(:match)
        q.name = "#{name}-#{num.to_s}-b1match4x4-#{p_table.name}"
        q.text = random_image_for(name) + lang.text_for(:b1, name, p_table.fields[index1].capitalize, p_table.fields[index2].capitalize )
        q.matching << [ e[0][:data][index1], e[0][:data][index2] ]
        q.matching << [ e[1][:data][index1], e[1][:data][index2] ]
        q.matching << [ e[2][:data][index1], e[2][:data][index2] ]
        q.matching << [ e[3][:data][index1], e[3][:data][index2] ]
        if list2.count > 0
          # Add an extra line from others similar tables
          q.matching << [ '', list2[0][:data][index2] ]
        end
        questions << q

        # Question type <b1match>: match 3 items from table-A and 1 item with error
        e.shuffle!
        q = Question.new(:match)
        q.name = "#{name}-#{num.to_s}-b1match3x1misspelled-#{p_table.name}"
        q.text = random_image_for(name) + lang.text_for(:b1, name, p_table.fields[index1].capitalize, p_table.fields[index2].capitalize )
        q.matching << [ e[0][:data][index1], e[0][:data][index2] ]
        q.matching << [ e[1][:data][index1], e[1][:data][index2] ]
        q.matching << [ e[2][:data][index1], e[2][:data][index2] ]
        q.matching << [ lang.do_mistake_to(e[3][:data][index1]), lang.text_for(:misspelling) ]
        questions << q
      end
    end

    if list1.count > 2 && list2.count > 0
      s = Set.new
      list1.each do |i|
        s.add( i[:data][index1] + '<=>' + i[:data][index2] )
      end
      s.add( list2[0][:data][index1] + '<=>' + list2[0][:data][index2] )
      a = s.to_a

      # Question 3 items from table-A, and 1 item from table-B
      if s.count > 3
        q = Question.new(:match)
        q.name = "#{name}-#{num.to_s}-b1match3x1-#{p_table.name}"
        q.text = random_image_for(name) + lang.text_for(:b1, name , p_table.fields[index1].capitalize, p_table.fields[index2].capitalize)
        q.matching << [ list1[0][:data][index1], list1[0][:data][index2] ]
        q.matching << [ list1[1][:data][index1], list1[1][:data][index2] ]
        q.matching << [ list1[2][:data][index1], list1[2][:data][index2] ]
        q.matching << [ list2[0][:data][index1], lang.text_for(:error) ]
        questions << q
      end
    end

    return questions
  end

end
