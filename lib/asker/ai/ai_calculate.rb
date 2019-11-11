# frozen_string_literal: true

# Methods that calculate something
module AI_calculate
  def get_list1_and_list2_from(ltable)
    # create <list1> with all the rows from the table
    list1 = []
    count = 1
    ltable.rows.each do |i|
      list1 << { id: count, weight: 0, data: i }
      count += 1
    end

    # create a <list2> with similar rows (same table name) from the neighbours tables
    list2 = []
    neighbors.each do |n|
      n[:concept].tables.each do |t2|
        next if t2.name != ltable.name
        t2.rows.each do |i|
          list2 << { id: count, weight: 0, data: i }
          count += 1
        end
      end
    end
    return list1, list2
  end

  def calculate_nearness_between_texts(text1, text2)
    return 0.0 if text2.nil? || text2.empty?

    words = text1.split(' ')
    count = 0
    words.each { |w| count += 1 if text2.include?(w) }
    (count * 100 / words.count)
  end

  def reorder_list_with_row(list, row)
    # evaluate every row of the list2
    list.each do |r|
      if r[:id] == row[:id]
        r[:weight] = -300
      else
        val = 0
        s = row[:data].count
        s.times do |i|
          val += calculate_nearness_between_texts(row[:data][i], r[:data][i])
        end
        val /= s
        r[:weight] = val
      end
    end
    list.sort! { |a, b| a[:weight] <=> b[:weight] }
    list.reverse!
  end
end
