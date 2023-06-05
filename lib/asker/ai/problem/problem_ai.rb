require_relative "../../lang/lang_factory"
require_relative "../question"

class ProblemAI
  attr_accessor :problem

  def call(problem)
    @problem = problem
    make_questions
    @problem
  end

  def make_questions
    @counter = 0
    @questions = []
    @customs = get_customs(@problem)
    make_questions_with_aswers
    make_questions_with_steps
    @problem.questions = @questions
  end

  private

  def counter
    @counter += 1
  end

  def customize(text:, custom:)
    output = text.clone
    custom.each_pair { |oldvalue, newvalue| output.gsub!(oldvalue, newvalue) }
    output
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
        correct_answer = customize(text: ask[:answer], custom: custom)

        # Question boolean => true
        q = Question.new(:boolean)
        q.name = "#{name}-#{counter}-problem1a-true"
        q.text = lang.text_for(:problem1a, desc, asktext, correct_answer)
        q.good = "TRUE"
        @questions << q

        # Locate incorrect answers
        incorrect_answers = []
        @customs.each do |aux|
          next if aux == custom
          incorrect = customize(text: ask[:answer], custom: aux)
          incorrect_answers << incorrect if incorrect != correct_answer
        end

        # Question boolean => true
        if incorrect_answers.size > 0
          q = Question.new(:boolean)
          q.name = "#{name}-#{counter}-problem1a-false"
          q.text = lang.text_for(:problem1a, desc, asktext, incorrect_answers.first)
          q.good = "FALSE"
          @questions << q
        end

        # Question choice NONE
        if incorrect_answers.size > 2
          q = Question.new(:choice)
          q.name = "#{name}-#{counter}-problem1b-choice"
          q.text = lang.text_for(:problem1b, desc, asktext)
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
          q.name = "#{name}-#{counter}-problem1b-choice"
          q.text = lang.text_for(:problem1b, desc, asktext)
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
          q.name = "#{name}-#{counter}-problem1b-choice"
          q.text = lang.text_for(:problem1b, desc, asktext)
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
        q.name = "#{name}-#{counter}-problem1b-short"
        q.text = lang.text_for(:problem1b, desc, asktext)
        q.shorts << correct_answer
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

          puts lines_to_s(steps)
        end
      end
    end
  end
end
