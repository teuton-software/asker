# frozen_string_literal: true

require_relative "base_stage"
require_relative "../question"

class StageS < BaseStage
  # process_sequence
  def run(table, list1, _list2)
    questions = []
    return questions unless table.fields.count == 1 && table.sequence? && table.sequence[0] != ""

    lang = concept.lang
    # Question: items are part of a sequence
    if list1.count > 3
      a = 0..(list1.count - 4)
      a.each_entry do |i|
        q = Question.new(:match)
        q.name = "#{name}-#{num}-s1sequence-#{table.name}"
        q.text = random_image_for(name) + lang.text_for(:s1, name, table.fields[0].capitalize, table.sequence[0])
        q.matching << [list1[i + 0][:data][0], "1º"]
        q.matching << [list1[i + 1][:data][0], "2º"]
        q.matching << [list1[i + 2][:data][0], "3º"]
        q.matching << [list1[i + 3][:data][0], "4º"]
        q.matching << ["", lang.text_for(:error)]
        questions << q
      end

      q = Question.new(:ordering)
      q.name = "#{name}-#{num}-s1sequence-#{table.name}"
      q.text = random_image_for(name) + lang.text_for(:s1, name, table.fields[0].capitalize, table.sequence[0])
      list1.each { |item| q.ordering << item[:data][0] }
      questions << q
    end

    # Question: items are part of a reverse sequence
    if list1.count > 3 && table.sequence.size > 1
      a = 0..(list1.count - 4)
      a.each_entry do |i|
        q = Question.new
        q.set_match
        q.name = "#{name}-#{num}-s2sequence-#{table.name}"
        q.text = random_image_for(name) + lang.text_for(:s1, name, table.fields[0].capitalize, table.sequence[1])
        q.matching << [list1[i + 3][:data][0], "1º"]
        q.matching << [list1[i + 2][:data][0], "2º"]
        q.matching << [list1[i + 1][:data][0], "3º"]
        q.matching << [list1[i + 0][:data][0], "4º"]
        q.matching << ["", lang.text_for(:error)]
        questions << q
      end

      q = Question.new(:ordering)
      q.name = "#{name}-#{num}-s2sequence-#{table.name}"
      q.text = random_image_for(name) + lang.text_for(:s1, name, table.fields[0].capitalize, table.sequence[1])
      list1.reverse.to_a.each { |item| q.ordering << item[:data][0] }
      questions << q
    end

    questions
  end
end
