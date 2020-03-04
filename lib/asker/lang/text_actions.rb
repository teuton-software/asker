# encoding: utf-8

##
# Set of functions used by Lang class
module TextActions
  ##
  # Return text indicated by lang code...
  def text_for(option, *input)
    text1 = input[0]
    text2 = input[1]
    text3 = input[2]
    text4 = input[3]
    text5 = input[4]
    text6 = input[5]
    text7 = input[6]

    # Check if exists option before use it
    raise "[ERROR] Unkown template #{option}" if @templates[option].nil?

    renderer = ERB.new(@templates[option])
    renderer.result(binding)
  end

  ##
  # Convert input text into output text struct
  # @param input (String) Input text
  # @param filter (Boolean) true => apply filter, false => dont filter
  # @return Array
  def text_filter_connectors(input, filter)
    input_lines = input.split('.')
    output_lines = []
    output_words = []
    input_lines.each_with_index do |line, rowindex|
	    row = []
      line.split(' ').each_with_index do |word, colindex|
        flag = @connectors.include? word.downcase

	      # if <word> is a conector and <pFilter>==true Then Choose this <word>
	      # if <word> isn't a conector and <pFilter>==true and <word>.length>1 Then Choose this <word>
        if (flag and filter) || (!flag and !filter and word.length > 1)
		      output_words << {:word => word, :row => rowindex, :col => colindex }
		      row << (output_words.size-1)
	      else
		      row << word
        end
	    end
	    row << '.'
	    output_lines << row
    end

    indexes = []
    exclude = ['[', ']', '(', ')', '"']
    output_words.each_with_index do |item, index|
      flag = true
      exclude.each { |e| flag = false if item[:word].include? e }
      indexes << index if flag
    end

    { lines: output_lines, words: output_words, indexes: indexes }
  end

  ##
  # Return text with connectors
  def text_with_connectors(text)
	  text_filter_connectors(text, false)
  end

  ##
  # Return text without connectors
  def text_without_connectors(text)
    text_filter_connectors(text, true)
  end

  def build_text_from_filtered(input_struct, input_indexes)
    lines = input_struct[:lines]
    indexes = input_indexes.sort
    counter = 1
    text = ''

    lines.each do |line|
      line.each do |value|
        if value.class == String
          text += (' ' + value)
        elsif value == value.to_i
          # INFO: ruby 2.4 unifies Fixnum and Bignum into Integer
          #       Avoid using deprecated classes.
          if indexes.include? value
            text += " [#{counter}]"
            counter += 1
          else
            word = input_struct[:words][value][:word]
            text += (' ' + word)
          end
        end
      end
    end
    text.gsub!(' .', '.')
    text.gsub!(' ,', ',')
    text = text[1, text.size] if text[0] == ' '
    text
  end

  ##
  # Count words
  # @param input (String)
  # @return Integer
  def count_words(input)
    return 0 if input.nil?

    t = input.clone
    t.gsub!("\n", ' ')
    t.gsub!('/', ' ')
    # t.gsub!("-"," ")
    t.gsub!('.', ' ')
    t.gsub!(',', ' ')
    t.gsub!('   ', ' ')
    t.gsub!('  ', ' ')
    t.split(' ').count
  end

  ##
  # Do mistake to input
  # @param input (String)
  # @return String
  def do_mistake_to(input = '')
    text = input.dup
    keys = @mistakes.keys

    # Try to do mistake with one item from the key list
    keys.shuffle!
    keys.each do |key|
      next unless text.include? key.to_s

      values = @mistakes[key].split(',')
      values.shuffle!
      text = text.sub(key.to_s, values[0].to_s)
      return text
    end

    # Force mistake by swapping letters
    if text.size > 1
      i = rand(text.size - 2)
      aux = text[i]
      text[i] = text[i + 1]
      text[i + 1] = aux
    end
    return text if text != input

    text + 's'
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
