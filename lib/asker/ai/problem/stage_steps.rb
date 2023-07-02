require_relative "../question"

module StageSteps
  def make_questions_with_steps
    name = @problem.name
    lang = @problem.lang

    @customs.each do |custom|
      desc = customize(text: @problem.desc, custom: custom)

      @problem.asks.each do |ask|
        next if ask[:text].nil?
        asktext = customize(text: ask[:text], custom: custom)
        next if ask[:steps].nil? || ask[:steps].empty?
        steps = ask[:steps].map { |step| customize(text: step, custom: custom) }

        # Question steps ok
        q = Question.new(:short)
        q.name = "#{name}-#{counter}-07ps3short-ok"
        q.text = lang.text_for(:ps3, desc, asktext, lines_to_s(steps))
        q.shorts << 0
        @questions << q

        # Question steps ordering
        if steps.size > 3
          q = Question.new(:ordering)
          q.name = "#{name}-#{counter}-08ps6ordering"
          q.text = lang.text_for(:ps6, desc, asktext, lines_to_s(steps))
          steps.each { |step| q.ordering << step }
          @questions << q
        end

        # Question steps hide
        if steps.size > 3
          (0...(steps.size)).each do |index|
            q = Question.new(:short)
            q.name = "#{name}-#{counter}-09ps7short-hide"
            hide_steps = steps.clone
            hide_steps[index] = hide(steps[index])
            q.text = lang.text_for(:ps7, desc, asktext, lines_to_s(hide_steps))
            q.shorts << steps[index]
            @questions << q
          end
        end

        # Using diferents wrong steps sequences
        max = steps.size - 1
        (0..max).each do |index|
          change = rand(max + 1)
          bads = steps.clone

          minor = index
          major = change
          if minor > major
            minor, major = major, minor
          elsif minor == major
            next
          end
          bads[minor], bads[major] = bads[major], bads[minor]

          # Question steps error
          q = Question.new(:short)
          q.name = "#{name}-#{counter}-10ps3short-error"
          q.text = lang.text_for(:ps3, desc, asktext, lines_to_s(bads))
          q.shorts << minor + 1
          q.feedback = lang.text_for(:ps4, minor + 1, major + 1)
          @questions << q
        end

        # Match questions
        indexes = (0..(steps.size - 1)).to_a.shuffle
        (0..(steps.size - 4)).each do |first|
          incomplete_steps = steps.clone
          incomplete_steps[indexes[first]] = "?"
          incomplete_steps[indexes[first + 1]] = "?"
          incomplete_steps[indexes[first + 2]] = "?"
          incomplete_steps[indexes[first + 3]] = "?"

          q = Question.new(:match)
          q.name = "#{name}-#{counter}-11ps5match"
          q.text = lang.text_for(:ps5, desc,  asktext, lines_to_s(incomplete_steps))
          q.matching << [steps[indexes[first]], (indexes[first] + 1).to_s]
          q.matching << [steps[indexes[first + 1]], (indexes[first + 1] + 1).to_s]
          q.matching << [steps[indexes[first + 2]], (indexes[first + 2] + 1).to_s]
          q.matching << [steps[indexes[first + 3]], (indexes[first + 3] + 1).to_s]
          q.matching << ["", lang.text_for(:error)]
          @questions << q

          q = Question.new(:ddmatch)
          q.name = "#{name}-#{counter}-12ps5ddmatch"
          q.text = lang.text_for(:ps5, desc,  asktext, lines_to_s(incomplete_steps))
          q.matching << [(indexes[first] + 1).to_s, steps[indexes[first]]]
          q.matching << [(indexes[first + 1] + 1).to_s, steps[indexes[first + 1]]]
          q.matching << [(indexes[first + 2] + 1).to_s, steps[indexes[first + 2]]]
          q.matching << [(indexes[first + 3] + 1).to_s, steps[indexes[first + 3]]]
          q.matching << ["", lang.text_for(:error)]
          @questions << q
        end
      end
    end 
  end
end