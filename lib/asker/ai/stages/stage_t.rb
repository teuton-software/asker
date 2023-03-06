require "set"
require_relative "base_stage"
require_relative "../question"

##
# StageT create questions based con Table data
# range t1-t9
class StageT < BaseStage
  # process_tableXfields
  def run(table, row, list)
    questions = []
    return questions unless concept.type == "text"

    if table.fields.count == 2
      questions += process_table2fields(table, row, list, 0, 1)
    elsif table.fields.count == 3
      questions += process_table2fields(table, row, list, 0, 1)
      questions += process_table2fields(table, row, list, 0, 2)
    elsif table.fields.count == 4
      questions += process_table2fields(table, row, list, 0, 1)
      questions += process_table2fields(table, row, list, 0, 2)
      questions += process_table2fields(table, row, list, 0, 3)
    end

    questions
  end

  private

  def process_table2fields(table, row, list, col1, col2)
    questions = []
    lang = concept.lang

    # Question choice: Using the column #0
    s = Set.new [row[:data][col1], lang.text_for(:none)]
    list.each { |i| s.add(i[:data][col1]) }
    a = s.to_a

    if s.count > 3
      q = Question.new
      q.set_choice
      q.name = "#{name}-#{num}-t1table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t1table, name, table.fields[col1].capitalize, \
                             table.fields[col2].capitalize, row[:data][col2])
      q.good = row[:data][col1]
      q.bads << lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      questions << q
    end

    # REPETIDO???
    # s = Set.new [row[:data][col1], lang.text_for(:none)]
    # list.each { |i| s.add(i[:data][col1]) }
    # a = s.to_a

    if s.count > 4
      q = Question.new
      q.set_choice
      q.name = "#{name}-#{num}-t2table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t2table, name, table.fields[col1].capitalize, \
                             table.fields[col2].capitalize, row[:data][col2])
      q.good = lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      q.bads << a[4]
      questions << q
    end

    # Question choice: Using the column #1
    s = Set.new [row[:data][col2], lang.text_for(:none)]
    list.each { |i| s.add(i[:data][col2]) }
    a = s.to_a

    if s.count > 3
      q = Question.new
      q.set_choice
      q.name = "#{name}-#{num}-t3table-#{table.name}"
      q.text = random_image_for(name) \
            +  lang.text_for(:t3table, name, table.fields[col1].capitalize, \
                             row[:data][col1], table.fields[col2].capitalize)
      q.good = a[0]
      q.bads << lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      questions << q
    end

    # REPTIDO???
    # s = Set.new [row[:data][col2], lang.text_for(:none)]
    # list.each { |i| s.add(i[:data][col2]) }
    # a = s.to_a

    if s.count > 4
      q = Question.new
      q.set_choice
      q.name = "#{name}-#{num}-t4table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t4table, name, table.fields[col1].capitalize, \
                             row[:data][col1], table.fields[col2].capitalize)
      q.good = lang.text_for(:none)
      q.bads << a[2]
      q.bads << a[3]
      q.bads << a[4]
      questions << q
    end

    # Question Boolean: TRUE
    q = Question.new
    q.set_boolean
    q.name = "#{name}-#{num}t5table-#{table.name}"
    q.text = random_image_for(name) \
           + lang.text_for(:t5table, name, table.fields[col1].capitalize, \
                           row[:data][col1], table.fields[col2].capitalize, row[:data][col2])
    q.good = "TRUE"
    questions << q

    # Question Boolean: FALSE
    s = Set.new [row[:data][col2]]
    list.each { |i| s.add(i[:data][col2]) }
    a = s.to_a

    if s.count > 1
      q = Question.new
      q.set_boolean
      q.name = "#{name}-#{num}-t6table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t6table, name, table.fields[col1].capitalize, \
                             row[:data][col1], table.fields[col2].capitalize, a[1])
      q.good = "FALSE"
      questions << q
    end

    s = Set.new [row[:data][col1]]
    list.each { |i| s.add(i[:data][col1]) }
    a = s.to_a

    if s.count > 1
      q = Question.new
      q.set_boolean
      q.name = "#{name}-#{num}t7table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t7table, name, table.fields[col1].capitalize, \
                             a[1], table.fields[col2].capitalize, row[:data][col2])
      q.good = 'FALSE'
      questions << q
    end

    # Question Short: column #0, 1 word
    if lang.count_words(row[:data][col1]) == 1
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num}t8table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t8table, name, table.fields[col2].capitalize, \
                             row[:data][col2], table.fields[col1].capitalize)
      q.shorts << row[:data][col1]
      q.shorts << row[:data][col1].gsub('-', ' ').gsub('_', ' ')
      questions << q
    elsif lang.count_words(row[:data][col1]) == 2
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num}t9table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t9table, name, table.fields[col2].capitalize, \
                             row[:data][col2], table.fields[col1].capitalize, \
                             "[#{lang.hide_text(row[:data][col1])}]", lang.count_words(row[:data][col1]))
      q.shorts << row[:data][col1]
      q.shorts << row[:data][col1].gsub('-', ' ').gsub('_', ' ')
      questions << q
    end

    # Question Short: column #1, 1 word
    if lang.count_words(row[:data][col2]) == 1
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num}t8table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t8table, name, table.fields[col1].capitalize, \
                             row[:data][col1], table.fields[col2].capitalize)
      q.shorts << row[:data][col2]
      q.shorts << row[:data][col2].gsub('-', ' ').gsub('_', ' ')
      questions << q
    elsif lang.count_words(row[:data][col2]) == 2
      q = Question.new
      q.set_short
      q.name = "#{name}-#{num}t9table-#{table.name}"
      q.text = random_image_for(name) \
             + lang.text_for(:t9table, name, table.fields[col1].capitalize, \
                             row[:data][col1], table.fields[col2].capitalize, \
                             "[#{lang.hide_text(row[:data][col2])}]", lang.count_words(row[:data][col2]))
      q.shorts << row[:data][col2]
      q.shorts << row[:data][col2].gsub('-', ' ').gsub('_', ' ')
      questions << q
    end
    questions
  end
end
