# frozen_string_literal: true

require_relative 'stages/main'
require_relative 'ai_calculate'

# Description: Method to be included into every ConceptAI instance.
# * make_questions: use AI to fill @questions Array
module AI
  include AICalculate

  def make_questions
    return unless concept.process?

    make_questions_stages_di
    # Process every table of this concept
    concept.tables.each do |table|
      list1, list2 = get_list1_and_list2_from(table)
      make_questions_stages_bsf(table, list1, list2)
      make_questions_stages_t(table, list1, list2)
    end
    # -------------------------------------------------------
    # Exclude questions as is defined into asker.ini params
    exclude_questions
  end

  # Make questions for states D and I
  def make_questions_stages_di
    @questions[:d] = StageD.new(self).run  # Process every def{type=text}
    @questions[:i] = StageI.new(self).run  # Process every def{type=image_url}
  end

  # Make questions for stages B, S and F
  def make_questions_stages_bsf(table, list1, list2)
    # Stage B: process table to make match questions
    @questions[:b] += StageB.new(self).run(table, list1, list2)
    # Stage S: process tables with sequences
    @questions[:s] += StageS.new(self).run(table, list1, list2)
    # Stage F: process tables with only 1 field
    @questions[:f] += StageF.new(self).run(table, list1, list2)
  end

  def make_questions_stages_t(table, list1, list2)
    # Stage T: process_tableXfields
    list3 = list1 + list2
    list1.each do |row|
      reorder_list_with_row(list3, row)
      @questions[:t] += StageT.new(self).run(table, row, list3)
    end
  end

  def exclude_questions
    param = Application.instance.config['questions']['exclude']
    return if param.nil?

    tags = param.split(',').each(&:strip!)
    input = { d: [], b: [], f: [], i: [], s: [], t: [] }
    output = { d: [], b: [], f: [], i: [], s: [], t: [] }

    @questions.each_pair do |key, qlist|
      output[key] = qlist.select { |q| string_has_this_tags?(q.name, tags) }
      input[key] = @questions[key] - output[key]
    end
    @questions = input
    @excluded_questions = output
  end

  def string_has_this_tags?(input, tags)
    flag = false
    tags.each { |e| flag = true if input.include? e }
    flag
  end
end
