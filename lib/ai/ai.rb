# frozen_string_literal: true

require_relative 'stages/main'
require_relative 'ai_calculate'

# Description: Method to be included into every ConceptAI instance.
# * make_questions: use AI to fill @questions Array
module AI
  include AI_calculate

  def make_questions
    return unless process?

    @questions[:d] = StageD.new(self).run  # Process every def{type=text}
    @questions[:i] = StageI.new(self).run  # Process every def{type=image_url}
    @questions[:b] = []
    @questions[:f] = []
    @questions[:s] = []
    @questions[:t] = []

    #------------------------------------
    # Process every table of this concept
    tables.each do |tab|
      list1, list2 = get_list1_and_list2_from(tab)

      #-----------------------------------------------
      # Stage B: process table to make match questions
      @questions[:b] += StageB.new(self).run(tab, list1, list2)
      #---------------------------------------
      # Stage S: process tables with sequences
      @questions[:s] += StageS.new(self).run(tab, list1, list2)
      #------------------------------------------
      # Stage F: process tables with only 1 field
      @questions[:f] += StageF.new(self).run(tab, list1, list2)
      #------------------------------
      # Stage T: process_tableXfields
      list3 = list1 + list2
      list1.each do |row|
        reorder_list_with_row(list3, row)
        @questions[:t] += StageT.new(self).run(tab, row, list3)
      end
    end
    # -------------------------------------------------------
    # Exclude questions as is defined into config.ini params
    exclude_questions
  end

  def exclude_questions
    param = Application.instance.config['questions']['exclude']
#    param = 'table, -t1, -t2, -t3, -t4, -t5, -t6, -t7, -t8, -t9'
    return if param.nil?

    excludes = param.split(',')
    excludes.each(&:strip!)
    questions = @questions
    @excluded_questions = {}
    questions.each_pair do |key, list|
      @excluded_questions[key] = @excluded_questions[key] || []
      list.each do |q|
        flag = false
        excludes.each { |e| flag = true if q.name.include? e }
        if flag
          puts q.name
          @excluded_questions[key] << q
          @questions[key].delete q
        end
      end
    end
  end
end
