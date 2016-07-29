# encoding: utf-8

module IA_calculate

  def calculate_nearness_between_texts(pText1, pText2)
    return 0.0 if pText2.nil? or pText2.size==0

    words=pText1.split(" ")
    count=0
    words.each { |w| count +=1 if pText2.include?(w) }
    return (count*100/words.count)
  end	

  def calculate_nearness_to_concept(pConcept)
    liMax1=@data[:context].count
    liMax2=@data[:tags].count
    liMax3=@data[:tables].count

    lfAlike1=0.0
    lfAlike2=0.0
    lfAlike3=0.0

    @data[:context].each { |i| lfAlike1+=1.0 if !pConcept.context.index(i).nil? }
    @data[:tags].each { |i| lfAlike2+=1.0 if !pConcept.tags.index(i).nil? }
    @data[:tables].each { |i| lfAlike3+=1.0 if !pConcept.tables.index(i).nil? }

    lfAlike =(lfAlike1*@weights[0]+lfAlike2*@weights[1]+lfAlike3*@weights[2])
    liMax = (liMax1*@weights[0]+liMax2*@weights[1]+liMax3*@weights[2])
    return ( lfAlike*100.0/ liMax )
  end

  def not_equals(a,b,c,d)
    return (a!=b && a!=c && a!=d && b!=c && b!=d && c!=d)
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
