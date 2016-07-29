# encoding: utf-8

require_relative '../lang/lang'
require_relative '../ia/ia'
require_relative 'question'

class ConceptIA
  include IA

  attr_reader :concept

  def initialize(concept)
    @concept = concept
    @questions={}
  end

  def make_questions_from_ia
    return if @concept.process==false

    #Stage A: IA process every <def> definition
    @questions[:stage_a] = run_stage_a
    @questions[:stage_b] = []
    @questions[:stage_c] = []
    @questions[:stage_d] = []
    @questions[:stage_e] = []

    #IA process every table of this concept
    @concept.tables.each do |lTable|
      #create <list1> with all the rows from the table
      list1=[]
      count=1
      lTable.rows.each do |i|
        list1 << { :id => count, :name => @concept.name, :weight => 0, :data => i }
        count+=1
      end

      #create a <list2> with similar rows (same table name) from the neighbours
      list2=[]
      @concept.neighbors.each do |n|
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

      #Stage B: process table match
      @questions[:stage_b] = @questions[:stage_b] + run_stage_b(lTable, list1, list2)

      #Stage C: process_tableXfields
      list1.each do |lRow|
        reorder_list_with_row(list3, lRow)
        @questions[:stage_c] = @questions[:stage_c] + run_stage_c(lTable, lRow, list3)
      end

      #Stage D: process table1field
      @questions[:stage_d] = @questions[:stage_d] + run_stage_d(lTable, list1, list2)

      #Stage E: process sequence
      @questions[:stage_e] = @questions[:stage_e] + run_stage_e(lTable, list1, list2)
    end
  end
end
