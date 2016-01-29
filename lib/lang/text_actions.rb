# encoding: utf-8

module TextActions
	
  def text_for(pOption, pText1="",pText2="",pText3="",pText4="",pText5="",pText6="",pText7="")
    text1=pText1
    text2=pText2
    text3=pText3
    text4=pText4
    text5=pText5
    text6=pText6
    text7=pText7
		
    renderer = ERB.new(@templates[pOption])
    output = renderer.result(binding)
    return output
  end
	
  def text_filter_connectors(pText, pFilter)
	input_lines=pText.split(".")
	output_lines=[]
	output_words=[]
	input_lines.each_with_index do |line, rowindex| 
	  row=[]
	  line.split(" ").each_with_index do |word,colindex|
		flag=@connectors.include? word.downcase
	    
	    # if <word> is a conector and <pFilter>==true Then Choose this <word>
	    # if <word> isn't a conector and <pFilter>==true and <word>.length>1 Then Choose this <word>
		if (flag and pFilter) or (!flag and !pFilter and word.length>1) then
		  output_words<< {:word => word, :row => rowindex, :col => colindex }
		  row << (output_words.size-1)
	    else
		  row << word
		end
	  end
	  row << "."
	  output_lines << row
	end		
	result={}
	result[:lines]=output_lines
	result[:words]=output_words
	return result
  end

  def text_with_connectors(pText)
	return text_filter_connectors(pText, false)
  end

  def text_without_connectors(pText)
	return text_filter_connectors(pText, true)
  end
	
  def build_text_from_filtered( pStruct, pIndexes)
    lines = pStruct[:lines]
				
    lText=""
    lines.each do |line|
      line.each do |value|
        if value.class==String
          lText+=" "+value 
        elsif value.class==Fixnum
          if pIndexes.include? value then
            lText+=" [#{value.to_s}]"
          else	
            lrow = pStruct[:words][value][:row]
            lcol = pStruct[:words][value][:col]
            lword = pStruct[:words][value][:word]
            lText+=" "+lword
          end
        end
      end
    end
    return lText
  end

  def do_mistake_to(pText)
    lText=pText.dup
    keys=@mistakes.keys
    
    keys.shuffle!
    keys.each do |key|
      if lText.include? key.to_s then
         values=@mistakes[key].split(",")
         values.shuffle!
         lText=lText.sub(key.to_s,values[0].to_s)
         return lText
      end
    end
    
    return lText
  end
  
end
