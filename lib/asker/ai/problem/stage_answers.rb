require_relative "../question"
require_relative "stage_base"

class StageAnswers < StageBase
  def make_questions
    name = @problem.name
    lang = @problem.lang
    questions = []

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
        questions << q

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
          questions << q
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
          questions << q
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
          questions << q
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
          questions << q
        end

        # Question short
        q = Question.new(:short)
        q.name = "#{name}-#{counter}-06pa2short"
        q.text = lang.text_for(:pa2, desc, asktext)
        q.shorts << correct_answer
        q.feedback = "Correct answer is #{correct_answer}."
        questions << q
      end
    end
    questions
  end
end
