# encoding: utf-8

require 'set'

require_relative 'base_stage'
require_relative '../question'

class StageI < BaseStage
  # range i1, i2, i3, i4

  def run
    # Stage I: process every image from <def> tag
    questions = []
    return questions unless type == 'text'

    # for every <image> do this
    images.each do |image|
      url = image[:url]
      s = Set.new [name, lang.text_for(:none)]
      neighbors.each { |n| s.add n[:concept].name }
      a = s.to_a

      # Question type <i1>: choose between 4 options
      if s.count > 3
        q = Question.new(:choice)
        q.name = "#{name}-#{num}-i1choice"
        q.text = lang.text_for(:i1, url )
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
        q.text = lang.text_for(:i1, url )
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
        q.name="#{name}-#{num}-i1none"
        q.text=lang.text_for(:i1, url )
        q.good=lang.text_for(:none)
        q.bads << a[1]
        q.bads << a[2]
        q.bads << a[3]
        questions << q
      end

      # Question type <i2>: boolean => TRUE
      q = Question.new(:boolean)
      q.name = "#{name}-#{num}-i2true"
      q.text = lang.text_for(:i2, url, name )
      q.good = 'TRUE'
      questions << q

      # Question type <i2>: boolean => FALSE
      if neighbors.count>0 then
        q = Question.new(:boolean)
        q.name = "#{name}-#{num}-i2false"
        q.text = lang.text_for(:i2, url, neighbors[0][:concept].name )
        q.good = 'FALSE'
        questions << q
      end

      # Question type <i3>: hidden name questions
      q = Question.new(:short)
      q.name = "#{name}-#{num}-i3short"
      q.text = lang.text_for(:i3, url, lang.hide_text(name) )
      q.shorts << name
      q.shorts << name.gsub('-', ' ').gsub('_', ' ')
      questions << q

      # Question filtered text questions
      texts.each do |t|
        filtered = lang.text_with_connectors(t)

        if filtered[:words].size >= 4
          indexes = filtered[:indexes]
          groups = (indexes.combination(4).to_a).shuffle
          max    = (indexes.size/4).to_i
          groups[0,max].each do |e|
            q = Question.new(:match)
            q.shuffle_off
            q.name = "#{name}-#{num}-i4filtered"
            e.sort!
            s = lang.build_text_from_filtered( filtered, e )
            q.text = lang.text_for(:i4, url , s)
            e.each_with_index do |value,index|
              q.matching << [ (index+1).to_s, filtered[:words][value][:word].downcase ]
            end
          end
          questions << q
        end
      end # each texts
    end # each images
    questions
  end
end
