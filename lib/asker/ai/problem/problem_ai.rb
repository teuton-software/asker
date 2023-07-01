require_relative "../../lang/lang_factory"
require_relative "../question"

class ProblemAI
  attr_accessor :problem

  def call(problem)
    @problem = problem
    @customs = get_customs(@problem)
    make_questions
    @problem
  end

  def make_questions
    @counter = 0
    @questions = []
    make_questions_with_aswers
    make_questions_with_steps
    @problem.questions = @questions
  end

  private

  def counter
    @counter += 1
  end

  def customize(text:, custom:, type: nil)
    output = text.clone
    custom.each_pair { |oldvalue, newvalue| output.gsub!(oldvalue, newvalue) }

    if type.nil?
      return output 
    elsif type == "formula"
      begin
        return eval(output).to_s
      rescue SyntaxError => e
        Logger.error "Problem.name = #{@problem.name}"
        Logger.error "ProblemAI: Wrong formula '#{text}' or wrong values '#{output}'"
        Logger.error e.to_s
        exit 1
      end
    else
      Logger.error "ProblemAI: Wrong answer type (#{type})"
      exit 1
    end
  end

  def get_customs(problem)
    customs = []
    vars = problem.varnames
    problem.cases.each do |acase|
      custom = {}
      vars.each_with_index { |varname, index| custom[varname] = acase[index] }
      customs << custom
    end
    customs
  end

  def lines_to_s(lines)
    output = ""
    lines.each_with_index do |line, index|
      output << "%2d: #{line}\n" % (index + 1)
    end
    output
  end

  def make_questions_with_aswers
    name = @problem.name
    lang = @problem.lang

    @customs.each do |custom|
      desc = customize(text: @problem.desc, custom: custom)

      @problem.asks.each do |ask|
        next if ask[:text].nil?
        asktext = customize(text: ask[:text], custom: custom)
        next if ask[:answer].nil?

        correct_answer = customize(
          text: ask[:answer], 
          custom: custom,
          type: ask[:answer_type]
        )

        # Question boolean => true
        q = Question.new(:boolean)
        q.name = "#{name}-#{counter}-01pa1true"
        q.text = lang.text_for(:pa1, desc, asktext, correct_answer)
        q.good = "TRUE"
        @questions << q

        # Locate incorrect answers
        incorrect_answers = []
        @customs.each do |aux|
          next if aux == custom
          incorrect = customize(
            text: ask[:answer], 
            custom: aux,
            type: ask[:answer_type]
            )
          incorrect_answers << incorrect if incorrect != correct_answer
        end

        # Question boolean => true
        if incorrect_answers.size > 0
          q = Question.new(:boolean)
          q.name = "#{name}-#{counter}-02pa1false"
          q.text = lang.text_for(:pa1, desc, asktext, incorrect_answers.first)
          q.good = "FALSE"
          @questions << q
        end

        # Question choice NONE
        if incorrect_answers.size > 2
          q = Question.new(:choice)
          q.name = "#{name}-#{counter}-03pa2-choice-none"
          q.text = lang.text_for(:pa2, desc, asktext)
          q.good = lang.text_for(:none)
          incorrect_answers.shuffle!
          q.bads << incorrect_answers[0]
          q.bads << incorrect_answers[1]
          q.bads << incorrect_answers[2]
          q.feedback = "Correct answer is #{correct_answer}."
          @questions << q
        end

        # Question choice OK
        if incorrect_answers.size > 2
          q = Question.new(:choice)
          q.name = "#{name}-#{counter}-04pa2choice"
          q.text = lang.text_for(:pa2, desc, asktext)
          q.good = correct_answer
          incorrect_answers.shuffle!
          q.bads << incorrect_answers[0]
          q.bads << incorrect_answers[1]
          q.bads << incorrect_answers[2]
          q.feedback = "Correct answer is #{correct_answer}."
          @questions << q
        end

        if incorrect_answers.size > 1
          q = Question.new(:choice)
          q.name = "#{name}-#{counter}-05pa2choice"
          q.text = lang.text_for(:pa2, desc, asktext)
          q.good = correct_answer
          incorrect_answers.shuffle!
          q.bads << incorrect_answers[0]
          q.bads << incorrect_answers[1]
          q.bads << lang.text_for(:none)
          q.feedback = "Correct answer is #{correct_answer}."
          @questions << q
        end

        # Question short
        q = Question.new(:short)
        q.name = "#{name}-#{counter}-06pa2short"
        q.text = lang.text_for(:pa2, desc, asktext)
        q.shorts << correct_answer
        q.feedback = "Correct answer is #{correct_answer}."
        @questions << q
      end
    end

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

    def hide(text)
      output = []
      text.chars do |c|
        output << if c == " "
          c
        else
          "?"
        end
      end
      output.join
    end
  end
end
