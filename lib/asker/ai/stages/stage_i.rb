# frozen_string_literal: true

require "set"

require_relative "base_stage"
require_relative "../question"

# range i1, i2, i3, i4
class StageI < BaseStage
  # Stage I: process every image from <def> tag
  # rubocop:disable Metrics/BlockLength
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def run
    questions = []
    return questions unless concept.type == "text"

    lang = concept.lang
    # for every <image> do this
    concept.images.each do |image|
      url = image[:text]
      s = Set.new [name, lang.text_for(:none)]
      concept.neighbors.each { |n| s.add n[:concept].name }
      a = s.to_a

      # Question type <i1>: choose between 4 options
      if s.count > 3
        q = Question.new(:choice)
        q.name = "#{name}-#{num}-i1choice"
        q.text = lang.text_for(:i1, url)
        q.encode = image[:file]
        q.good = name
        q.bads << lang.text_for(:none)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      # Question type <i1>: choose between 4 options, good none (Syntax error)
      if s.count > 3
        q = Question.new(:choice)
        q.name = "#{name}-#{num}-i1misspelling"
        q.text = lang.text_for(:i1, url)
        q.encode = image[:file]
        q.good = lang.text_for(:none)
        q.bads << lang.do_mistake_to(name)
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      s.delete(name)
      a = s.to_a

      # Question type <i1>: choose between 4 options, good none
      if s.count > 3
        q = Question.new(:choice)
        q.name = "#{name}-#{num}-i1none"
        q.text = lang.text_for(:i1, url)
        q.encode = image[:file]
        q.good = lang.text_for(:none)
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      # Question type <i2>: boolean => TRUE
      q = Question.new(:boolean)
      q.name = "#{name}-#{num}-i2true"
      q.text = lang.text_for(:i2, url, name)
      q.encode = image[:file]
      q.good = "TRUE"
      questions << q

      # Question type <i2>: boolean => FALSE
      if concept.neighbors.count.positive?
        q = Question.new(:boolean)
        q.name = "#{name}-#{num}-i2false"
        q.text = lang.text_for(:i2, url, concept.neighbors[0][:concept].name)
        q.encode = image[:file]
        q.good = "FALSE"
        questions << q
      end

      # Question type <i3>: hidden name questions
      q = Question.new(:short)
      q.name = "#{name}-#{num}-i3short"
      q.text = lang.text_for(:i3, url, lang.hide_text(name))
      q.encode = image[:file]
      q.shorts << name
      q.shorts << name.tr("-", " ").tr("_", " ")
      questions << q

      # Question filtered text questions
      concept.texts.each do |t|
        filtered = lang.text_with_connectors(t)
        next if filtered[:words].size < 4

        indexes = filtered[:indexes]
        groups = indexes.combination(4).to_a.shuffle
        max = (indexes.size / 4).to_i
        groups[0, max].each do |e|
          q = Question.new(:match)
          q.shuffle_off
          q.name = "#{name}-#{num}-i4filtered"
          q.encode = image[:file]
          e.sort!
          s = lang.build_text_from_filtered(filtered, e)
          q.text = lang.text_for(:i4, url, s)
          e.each_with_index do |value, index|
            q.matching << [index.next.to_s, filtered[:words][value][:word].downcase]
          end
        end
        questions << q
      end
    end
    questions
  end
  # rubocop:enable Metrics/BlockLength
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
