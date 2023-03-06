# frozen_string_literal: true

# Methods that calculate something
module AICalculate
  ##
  # Calculate and return list1 and list2
  # * return list1 (Array) List with all the rows from the table
  # * return list2 (Array) List with similar rows (same table name) from the neighbours tables
  # @param p_table (Table)
  def get_list1_and_list2_from(p_table)
    # create <list1> with all the rows from the table
    list1 = []
    count = 1
    p_table.rows.each do |i|
      list1 << { id: count, weight: 0, data: i }
      count += 1
    end

    # create a <list2> with similar rows (same table name) from the neighbours tables
    list2 = []
    concept.neighbors.each do |n|
      n[:concept].tables.each do |t2|
        next if t2.name != p_table.name

        t2.rows.each do |i|
          list2 << { id: count, weight: 0, data: i }
          count += 1
        end
      end
    end
    [list1, list2]
  end

  def calculate_nearness_between_texts(text1, text2)
    return 0.0 if text2.nil? || text2.empty?

    words = text1.split(' ')
    count = 0
    words.each { |w| count += 1 if text2.include?(w) }
    (count * 100 / words.count)
  end

  def reorder_list_with_row(list, row)
    # evaluate every row of the list, and calculate weight
    magic_number = -300
    list.each do |r|
      if r[:id] == row[:id]
        r[:weight] = magic_number
      else
        value = 0
        s = row[:data].count
        s.times do |i|
          value += calculate_nearness_between_texts(row[:data][i], r[:data][i])
        end
        value /= s
        r[:weight] = value
      end
    end
    list.sort! { |a, b| a[:weight] <=> b[:weight] }
    list.reverse!
  end
end
