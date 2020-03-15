
require 'set'
require_relative 'base_stage'
require_relative '../question'

##
# StageT create questions based con Table data
class StageT < BaseStage
  # range t1-t9

  def run(pTable, pRow, pList) # process_tableXfields
    questions = []
    return questions unless type == 'text'

    if pTable.fields.count > 1
      questions = questions + process_table2fields(pTable, pRow, pList, 0, 1)
    elsif pTable.fields.count > 2
      questions = questions + process_table2fields(pTable, pRow, pList, 0, 2)
      # questions = questions + process_table2fields(pTable, pRow, pList, 1, 2)
    elsif pTable.fields.count > 3
      questions = questions + process_table2fields(pTable, pRow, pList, 0, 3)
      # questions = questions + process_table2fields(pTable, pRow, pList, 1, 3)
      # questions = questions + process_table2fields(pTable, pRow, pList, 2, 3)
    end

    questions
  end

private
  def process_table2fields(lTable, lRow, pList, pCol1, pCol2)
    questions = []
    # create questions

    # Using the column #0
    s = Set.new [ lRow[:data][0] , lang.text_for(:none) ]
    pList.each { |i| s.add( i[:data][0] ) }
    a = s.to_a

    if s.count > 3
      q=Question.new
      q.name="#{name}-#{num.to_s}-t1table-#{lTable.name}"
      q.text=lang.text_for(:t1table, name, lTable.fields[0].capitalize, lTable.fields[1].capitalize, lRow[:data][1])
      q.good=lRow[:data][0]
      q.bads << lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      questions << q
    end

    s = Set.new [ lRow[:data][0], lang.text_for(:none) ]
    pList.each { |i| s.add( i[:data][0] ) }
    a = s.to_a

    if s.count > 4
      q = Question.new
      q.name = "#{name}-#{num.to_s}-t2table-#{lTable.name}"
      q.text = lang.text_for(:t2table, name, lTable.fields[0].capitalize, lTable.fields[1].capitalize, lRow[:data][1])
      q.good = lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      q.bads << a[4]
      questions << q
    end

    # Using the column #1
    s = Set.new [ lRow[:data][1], lang.text_for(:none) ]
    pList.each { |i| s.add( i[:data][1] ) }
    a = s.to_a

    if s.count > 3
      q = Question.new
      q.name = "#{name}-#{num.to_s}-t3table-#{lTable.name}"
      q.text = lang.text_for(:t3table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize)
      q.good = a[0]
      q.bads << lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      questions << q
    end

    s = Set.new [ lRow[:data][1], lang.text_for(:none) ]
    pList.each { |i| s.add( i[:data][1] ) }
    a = s.to_a

    if s.count > 4
      q = Question.new
      q.name = "#{name}-#{num.to_s}-t4table-#{lTable.name}"
      q.text = lang.text_for(:t4table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize)
      q.good = lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      q.bads << a[4]
      questions << q
    end

    # Boolean association TRUE
    q = Question.new
    q.set_boolean
    q.name = "#{name}-#{num.to_s}t5table-#{lTable.name}"
    q.text = lang.text_for(:t5table, name, lTable.fields[0].capitalize, lRow[:data][0] ,lTable.fields[1].capitalize, lRow[:data][1] )
    q.good = "TRUE"
    questions << q

    # Boolean association FALSE
    s = Set.new [ lRow[:data][1] ]
    pList.each { |i| s.add( i[:data][1] ) }
    a = s.to_a

    if s.count > 1
      q = Question.new
      q.set_boolean
      q.name = "#{name}-#{num.to_s}-t6table-#{lTable.name}"
      q.text = lang.text_for(:t6table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize, a[1] )
      q.good = "FALSE"
      questions << q
    end

    s = Set.new [ lRow[:data][0] ]
    pList.each { |i| s.add( i[:data][0] ) }
    a = s.to_a

    if s.count > 1
      q = Question.new
      q.set_boolean
      q.name = "#{name}-#{num.to_s}t7table-#{lTable.name}"
      q.text = lang.text_for(:t7table, name, lTable.fields[0].capitalize, a[1], lTable.fields[1].capitalize, lRow[:data][1] )
      q.good = "FALSE"
      questions << q
    end

    # Short answer with column #0, 1 word
    if lang.count_words(lRow[:data][0]) == 1
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num.to_s}t8table-#{lTable.name}"
      q.text = lang.text_for(:t8table, name, lTable.fields[1].capitalize, lRow[:data][1], lTable.fields[0].capitalize)
      q.shorts << lRow[:data][0]
      q.shorts << lRow[:data][0].gsub('-', ' ').gsub('_', ' ')
      questions << q
    elsif lang.count_words(lRow[:data][0]) == 2
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num.to_s}t9table-#{lTable.name}"
      q.text = lang.text_for(:t9table, name, lTable.fields[1].capitalize, lRow[:data][1], lTable.fields[0].capitalize, "[#{lang.hide_text(lRow[:data][0])}]", lang.count_words(lRow[:data][0]) )
      q.shorts << lRow[:data][0]
      q.shorts << lRow[:data][0].gsub('-', ' ').gsub('_', ' ')
      questions << q
    end

    # Short answer with column #1, 1 word
    if lang.count_words(lRow[:data][1]) == 1
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num.to_s}t8table-#{lTable.name}"
      q.text = lang.text_for(:t8table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize)
      q.shorts << lRow[:data][1]
      q.shorts << lRow[:data][1].gsub('-', ' ').gsub('_', ' ')
      questions << q
    elsif lang.count_words(lRow[:data][1]) == 2
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num.to_s}t9table-#{lTable.name}"
      q.text = lang.text_for(:t9table, name, lTable.fields[0].capitalize, lRow[:data][0], lTable.fields[1].capitalize, "[#{lang.hide_text(lRow[:data][1])}]", lang.count_words(lRow[:data][1]) )
      q.shorts << lRow[:data][1]
      q.shorts << lRow[:data][1].gsub('-', ' ').gsub('_', ' ')
      questions << q
    end
    questions
  end
end
