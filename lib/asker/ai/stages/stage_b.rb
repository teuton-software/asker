# frozen_string_literal: true

require 'set'

require_relative 'base_stage'
require_relative '../question'

##
# range b1
class StageB < BaseStage
  ##
  # Process table data to generate match questions
  # @param table (Table)
  # @param list1 (Array) Rows that belong to this table
  # @param list2 (Array) List with similar rows (same table name) from the neighbours tables
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def run(table, list1, list2)
    questions = []
    return questions if table.fields.count < 2

    return questions unless concept.type == 'text'

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
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  ##
  # Process table data to generate match questions
  # @param p_table (Table)
  # @param list1 (Array) Rows that belong to this table
  # @param list2 (Array) List with similar rows (same table name) from the neighbours tables
  # @param index1 (Integer) Use this field number
  # @param index2 (Integer) Use this field number
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  def process_table_match2fields(p_table, list1, list2, index1, index2)
    questions = []
    lang = concept.lang

    if list1.count > 3
      list1.each_cons(4) do |e1, e2, e3, e4|
        e = [e1, e2, e3, e4]

        # Question type <b1match>: match 4 items from the same table
        e.shuffle!
        q = Question.new(:match)
        q.name = "#{name}-#{num}-b1match4x4-#{p_table.name}"
        q.text = random_image_for(name) \
                 + lang.text_for(:b1, name, p_table.fields[index1].capitalize, p_table.fields[index2].capitalize)
        q.matching << [e[0][:data][index1], e[0][:data][index2]]
        q.matching << [e[1][:data][index1], e[1][:data][index2]]
        q.matching << [e[2][:data][index1], e[2][:data][index2]]
        q.matching << [e[3][:data][index1], e[3][:data][index2]]
        # Add an extra line
        if list2.count.positive?
          q.matching << ['', list2[0][:data][index2]]
        else
          q.matching << ['', lang.do_mistake_to(e[0][:data][index2])]
        end
        questions << q

        # Question type <b1match>: match 3 items from table-A and 1 item with error
        e.shuffle!
        q = Question.new(:match)
        q.name = "#{name}-#{num}-b1match3x1misspelled-#{p_table.name}"
        q.text = random_image_for(name) \
                 + lang.text_for(:b1, name, p_table.fields[index1].capitalize, p_table.fields[index2].capitalize)
        q.matching << [e[0][:data][index1], e[0][:data][index2]]
        q.matching << [e[1][:data][index1], e[1][:data][index2]]
        q.matching << [e[2][:data][index1], e[2][:data][index2]]
        q.matching << [lang.do_mistake_to(e[3][:data][index1]), lang.text_for(:misspelling)]
        # Add an extra line
        if list2.count.positive?
          q.matching << ['', list2[0][:data][index2]]
        else
          q.matching << ['', lang.do_mistake_to(e[0][:data][index2])]
        end
        questions << q
      end
    end

    if list1.count > 2 && list2.count.positive?
      s = Set.new
      list1.each do |i|
        s.add(i[:data][index1] + '<=>' + i[:data][index2])
      end
      s.add(list2[0][:data][index1] + '<=>' + list2[0][:data][index2])

      # Question 3 items from table-A, and 1 item from table-B
      if s.count > 3
        q = Question.new(:match)
        q.name = "#{name}-#{num}-b1match3x1-#{p_table.name}"
        q.text = random_image_for(name) \
                 + lang.text_for(:b1, name, p_table.fields[index1].capitalize, p_table.fields[index2].capitalize)
        q.matching << [list1[0][:data][index1], list1[0][:data][index2]]
        q.matching << [list1[1][:data][index1], list1[1][:data][index2]]
        q.matching << [list1[2][:data][index1], list1[2][:data][index2]]
        q.matching << [list2[0][:data][index1], lang.text_for(:error)]
        q.matching << ['', lang.do_mistake_to(list1[0][:data][index2])]
        questions << q
      end
    end

    questions
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
end
