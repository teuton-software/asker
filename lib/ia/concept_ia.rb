# encoding: utf-8

require 'set'

require_relative '../lang/lang'
require_relative '../application'
require_relative '../tool'
require_relative 'ia'
require_relative 'question'

class ConceptIA
  include IA

  attr_reader :concept
  attr_reader :questions

  def initialize(pConcept)
    @concept = pConcept
    @questions = []

    # ? @weights=Application.instance.formula_weights
    # ? @output=true
    # ? @filename=pFilename
  end

  def make_questions

    #IA process every <text> definition
    process_texts

    #IA process every table of this concept
    tables.each do |lTable|
      #create <list1> with all the rows from the table
      list1=[]
      count=1
      lTable.rows.each do |i|
        list1 << { :id => count, :name => name, :weight => 0, :data => i }
        count+=1
      end

      #create a <list2> with similar rows (same table name) from the neighbours
      list2=[]
      @data[:neighbors].each do |n|
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
      process_table_match(lTable, list1, list2)
      process_table1field(lTable, list1, list2)
      process_sequence(lTable, list1, list2)

      list1.each do |lRow|
        reorder_list_with_row(list3, lRow)
        process_tableXfields(lTable, lRow, list3)
      end
    end
  end

  def method_missing(m, *args, &block)
    return @concept.data[m]
  end

end
