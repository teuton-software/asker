# encoding: utf-8

module AI_calculate

  def get_list1_and_list2_from(lTable)
    #create <list1> with all the rows from the table
    list1=[]
    count=1
    lTable.rows.each do |i|
#      list1 << { :id => count, :name => name, :weight => 0, :data => i }
      list1 << { :id => count, :weight => 0, :data => i }
      count+=1
    end

    #create a <list2> with similar rows (same table name) from the neighbours tables
    list2=[]
    neighbors.each do |n|
      n[:concept].tables.each do |t2|
        if t2.name==lTable.name then
          t2.rows.each do |i|
#            list2 << { :id => count, :name => n[:concept].name, :weight => 0, :data => i }
            list2 << { :id => count, :weight => 0, :data => i }
            count+=1
          end
        end
      end
    end
    return list1, list2
  end

  def calculate_nearness_between_texts(pText1, pText2)
    return 0.0 if pText2.nil? or pText2.size==0

    words=pText1.split(" ")
    count=0
    words.each { |w| count +=1 if pText2.include?(w) }
    return (count*100/words.count)
  end

  def reorder_list_with_row(pList, pRow)
    #evaluate every row of the list2
    pList.each do |lRow|
      if lRow[:id]==pRow[:id] then
        lRow[:weight]=-300
      else
        val=0
        s=pRow[:data].count
        s.times do |i|
          val=val+calculate_nearness_between_texts(pRow[:data][i],lRow[:data][i])
        end
        val=val/s
        lRow[:weight]=val
      end
    end
    pList.sort! { |a,b| a[:weight] <=> b[:weight] }
    pList.reverse!
  end

end
