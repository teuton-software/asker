# encoding: utf-8

module AI_calculate
  def get_list1_and_list2_from(lTable)
    # create <list1> with all the rows from the table
    list1 = []
    count = 1
    lTable.rows.each do |i|
#      list1 << { :id => count, :name => name, :weight => 0, :data => i }
      list1 << { :id => count, :weight => 0, :data => i }
      count += 1
    end

    # create a <list2> with similar rows (same table name) from the neighbours tables
    list2 = []
    neighbors.each do |n|
      n[:concept].tables.each do |t2|
        if t2.name == lTable.name
          t2.rows.each do |i|
#            list2 << { :id => count, :name => n[:concept].name, :weight => 0, :data => i }
            list2 << { :id => count, :weight => 0, :data => i }
            count += 1
          end
        end
      end
    end
    return list1, list2
  end

  def calculate_nearness_between_texts(ptext1, ptext2)
    return 0.0 if ptext2.nil? || ptext2.empty?

    words = ptext1.split(' ')
    count = 0
    words.each { |w| count += 1 if ptext2.include?(w) }
    (count * 100 / words.count)
  end

  def reorder_list_with_row(p_list, p_row)
    # evaluate every row of the list2
    p_list.each do |l_row|
      if l_row[:id] == p_row[:id]
        l_row[:weight] = -300
      else
        val = 0
        s = p_row[:data].count
        s.times do |i|
          val += calculate_nearness_between_texts(p_row[:data][i], l_row[:data][i])
        end
        val /= s
        l_row[:weight] = val
      end
    end
    p_list.sort! { |a, b| a[:weight] <=> b[:weight] }
    p_list.reverse!
  end
end
