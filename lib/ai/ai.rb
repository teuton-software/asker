# encoding: utf-8

require 'set'

require_relative 'ai_stage_a'
require_relative 'ai_stage_b'
require_relative 'ai_stage_c'
require_relative 'ai_stage_d'
require_relative 'ai_stage_e'
require_relative 'stage_f'

require_relative 'ai_calculate'

module AI
  include AI_stage_a
  include AI_stage_b
  include AI_stage_c
  include AI_stage_d
  include AI_stage_e

  include AI_calculate

  def make_questions_from_ai
    return if @process==false

    #---------------------------------------------------------
    #Stage A: process every definition, I mean every <def> tag
    @questions[:stage_a] = run_stage_a
    @questions[:stage_b] = []
    @questions[:stage_c] = []
    @questions[:stage_d] = []
    @questions[:stage_e] = []
    @questions[:stage_f] = StageF.new(self).run

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
      @questions[:stage_b] = @questions[:stage_b] + run_stage_b(lTable, list1, list2)
      #-----------------------------
      #Stage C: process_tableXfields
      list1.each do |lRow|
        reorder_list_with_row(list3, lRow)
        @questions[:stage_c] = @questions[:stage_c] + run_stage_c(lTable, lRow, list3)
      end

      #-----------------------------------------
      #Stage D: process tables with only 1 field
      @questions[:stage_d] = @questions[:stage_d] + run_stage_d(lTable, list1, list2)

      #--------------------------------------
      #Stage E: process tables with sequences
      @questions[:stage_e] = @questions[:stage_e] + run_stage_e(lTable, list1, list2)
    end

    #-------------------------------------
    #Stage F: process images from def tags

  end
end
