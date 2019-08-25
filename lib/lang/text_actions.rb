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

	  # TODO: check if exists pOption before use it
    renderer = ERB.new(@templates[pOption])
    output = renderer.result(binding)
    return output
  end

  def text_filter_connectors(pText, pFilter)
    input_lines = pText.split(".")
    output_lines = []
    output_words = []
    input_lines.each_with_index do |line, rowindex|
	    row=[]
      line.split(' ').each_with_index do |word, colindex|
        flag = @connectors.include? word.downcase

	      # if <word> is a conector and <pFilter>==true Then Choose this <word>
	      # if <word> isn't a conector and <pFilter>==true and <word>.length>1 Then Choose this <word>
        if (flag and pFilter) || (!flag and !pFilter and word.length>1)
		      output_words << {:word => word,
                           :row => rowindex,
                           :col => colindex }
		      row << (output_words.size-1)
	      else
		      row << word
		    end
	    end
	    row << '.'
	    output_lines << row
	  end

    indexes = []
    exclude = ['[', ']', '(', ')', "\"" ]
    output_words.each_with_index do |item, index|
      flag = true
      exclude.each { |e| flag = false if (item[:word].include?(e)) }
      indexes << index if flag
    end

	  result={ :lines => output_lines, :words => output_words, :indexes => indexes }
	  return result
  end

  def text_with_connectors(text)
	  text_filter_connectors(text, false)
  end

  def text_without_connectors(text)
	  text_filter_connectors(text, true)
  end

  def build_text_from_filtered(pStruct, pIndexes)
    lines    = pStruct[:lines]
    lIndexes = pIndexes.sort
    counter  = 1
    lText    = ''

    lines.each do |line|
      line.each do |value|
        if value.class == String
          lText += (' ' + value)
        elsif value == value.to_i
          # INFO: ruby 2.4 unifies Fixnum and Bignum into Integer
          #       Avoid using deprecated classes.
          if lIndexes.include? value
            lText   += " [#{counter.to_s}]"
            counter += 1
          else
            lword = pStruct[:words][value][:word]
            lText += (' ' + lword)
          end
        end
      end
    end
    lText.gsub!(' .', '.')
    lText.gsub!(' ,', ',')
    lText = lText[1, lText.size] if lText[0] == ' '
    lText
  end

  def count_words(pInputText)
    return 0 if pInputText.nil?

    t = pInputText.clone
    t.gsub!("\n"," ")
    t.gsub!("/"," ")
    #t.gsub!("-"," ")
    t.gsub!("."," ")
    t.gsub!(","," ")
    t.gsub!("   "," ")
    t.gsub!("  "," ")
    t.split(" ").count
  end

  def do_mistake_to(pText = '')
    lText = pText.dup
    keys = @mistakes.keys

    # Try to do mistake with one item from the key list
    keys.shuffle!
    keys.each do |key|
      if lText.include? key.to_s
         values = @mistakes[key].split(',')
         values.shuffle!
         lText = lText.sub(key.to_s,values[0].to_s)
         return lText
      end
    end

    # Force mistake by swapping letters
    if lText.size > 1
      i = rand(lText.size - 2)
      aux = lText[i]
      lText[i] = lText[i + 1]
      lText[i + 1] = aux
    end
    return lText if lText != pText

    lText + 's'
  end

  def hide_text(input_text)
    input = input_text.clone
    if count_words(input) < 2 && input.size < 10
      output = '[*]'
    else
      output = ''
      input.each_char do |char|
        if ' !|"@#$%&/()=?¿¡+*(){}[],.-_<>'.include? char
          output += char
        else
          output += '?'
        end
      end
    end
    output
  end
end
