# encoding: utf-8

require 'set'

require_relative 'ai_stage_b'
require_relative 'ai_stage_c'
require_relative 'stage_d'
require_relative 'stage_f'
require_relative 'stage_i'
require_relative 'stage_s'

require_relative 'ai_calculate'

module AI
  include AI_stage_b
  include AI_stage_c

  include AI_calculate

  def make_questions_from_ai
    return if @process==false

    #---------------------------------------------------------
    #Stage D: process every definition, I mean every <def> tag
    @questions[:stage_d] = StageD.new(self).run
    @questions[:stage_i] = StageI.new(self).run
    @questions[:stage_b] = []
    @questions[:stage_c] = []
    @questions[:stage_f] = []
    @questions[:stage_s] = []

    #-----------------------------------
    #Process every table of this concept
    tables.each do |lTable|
      #create <list1> with all the rows from the table
      list1=[]
      count=1
      lTable.rows.each do |i|
        list1 << { :id => count, :name => @name, :weight => 0, :data => i }
        count+=1
      end

      #create a <list2> with similar rows (same table name) from the neighbours tables
      list2=[]
      neighbors.each do |n|
        n[:concept].tables.each do |t2|
          if t2.name==lTable.name then
            t2.rows.each do |i|
              list2 << { :id => count, :name => n[:concept].name, :weight => 0, :data => i }
              count+=1
            end
          end
        end
      end

      list3=list1+list2

      #----------------------------------------------
      #Stage B: process table to make match questions
      @questions[:stage_b] += run_stage_b(lTable, list1, list2)
      #-----------------------------
      #Stage C: process_tableXfields
      list1.each do |lRow|
        reorder_list_with_row(list3, lRow)
        @questions[:stage_c] += run_stage_c(lTable, lRow, list3)
      end

      #--------------------------------------
      #Stage S: process tables with sequences
      @questions[:stage_s] += StageS.new(self).run(lTable, list1, list2)
      #-----------------------------------------
      #Stage F: process tables with only 1 field
      @questions[:stage_f] += StageF.new(self).run(lTable, list1, list2)

    end
  end

  def random_image_for(concept)
    p = rand
    return "" if p<=0.5

    keys = @world.image_urls.keys
    keys.shuffle!
    values= @world.image_urls[ keys[0] ]
    return "" if values.nil?
    values.shuffle!
    return "<img src=\"#{values[0]}\" alt\=\"darts-of-teacher\"><br/>"
  end

end
