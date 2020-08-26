# frozen_string_literal: true

require_relative 'base_stage'
require_relative '../question'

# process_sequence
class StageS < BaseStage
  # process_sequence
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def run(table, list1, _list2)
    questions = []
    return questions unless table.fields.count == 1 && table.sequence? && table.sequence[0] != ''

    lang = concept.lang
    # Question type <d3sequence>: items are part of a sequence
    if list1.count > 3
      a = 0..(list1.count - 4)
      a.each_entry do |i|
        q = Question.new(:match)
        q.name = "#{name}-#{num}-s1sequence-#{table.name}"
        q.text = random_image_for(name) + lang.text_for(:s1, name, table.fields[0].capitalize, table.sequence[0])
        q.matching << [list1[i + 0][:data][0], '1º']
        q.matching << [list1[i + 1][:data][0], '2º']
        q.matching << [list1[i + 2][:data][0], '3º']
        q.matching << [list1[i + 3][:data][0], '4º']
        questions << q
      end
    end

    # Question type <d4sequence>: items are part of a reverse sequence
    if list1.count > 3 && table.sequence.size > 1
      a = 0..(list1.count - 4)
      a.each_entry do |i|
        q = Question.new
        q.set_match
        q.name = "#{name}-#{num}-s2sequence-#{table.name}"
        q.text = random_image_for(name) + lang.text_for(:s1, name, table.fields[0].capitalize, table.sequence[1])
        q.matching << [list1[i + 3][:data][0], '1º']
        q.matching << [list1[i + 2][:data][0], '2º']
        q.matching << [list1[i + 1][:data][0], '3º']
        q.matching << [list1[i + 0][:data][0], '4º']
        questions << q
      end
    end

    questions
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
