require_relative "check_table"

class CheckHamlData
  include CheckTable
  attr_reader :inputs, :outputs

  def initialize(filepath)
    @inputs = File.read(filepath).split("\n")
    @outputs = []
    @inputs.each_with_index do |line, index|
      output = {id: index,
                level: 0,
                state: :none,
                type: :none,
                source: line,
                msg: ""}
      @outputs << output
    end
    @ok = false
  end

  def ok?
    @ok
  end

  def show
    @outputs.each do |i|
      puts "#{i[:id]}: #{i[:state]} [#{i[:type]}] #{i[:msg]}"
    end
  end

  def show_errors
    errors = 0
    @outputs.each do |i|
      next if i[:state] == :ok

      errors += 1
      if errors < 11
        data = {id: i[:id], msg: i[:msg], source: i[:source][0, 40]}
        order = i[:id] + 1
        data = {order: order, msg: i[:msg], source: i[:source][0, 40]}
        message1 = Rainbow(" %<order>03d : %<msg>32s. => ").white
        message2 = Rainbow("%<source>s").yellow.bright
        output = format(message1, data) + format(message2, data)
        warn output
      end
      warn "..." if errors == 11
    end

    if errors.zero?
      puts Rainbow("Syntax OK!").green.bright
    else
      message = "\nRevise #{errors} syntax warning or error/s\n"
      warn Rainbow(message).yellow.bright
      exit 1
    end
  end

  def check
    @ok = true
    @inputs.each_with_index do |line, index|
      check_empty_lines(line, index)
      check_map(line, index)
      check_concept(line, index)
      check_names(line, index)
      check_tags(line, index)
      check_def(line, index)
      check_table(line, index)
      check_row(line, index)
      check_col(line, index)
      check_template(line, index)
      check_code(line, index)
      check_type(line, index)
      check_path(line, index)
      check_features(line, index)
      check_problem(line, index)
      check_cases(line, index)
      check_case(line, index)
      check_desc(line, index)
      check_ask(line, index)
      check_text(line, index)
      check_answer(line, index)
      check_step(line, index)
      check_unknown(line, index)
      @ok = false unless @outputs[index][:state] == :ok
      @ok = false if @outputs[index][:type] == :unkown
    end
    @ok
  end

  private

  def check_empty_lines(line, index)
    return unless line.strip.size.zero? || line.start_with?("#")

    @outputs[index][:type] = :empty
    @outputs[index][:level] = -1
    @outputs[index][:state] = :ok
  end

  def check_map(line, index)
    if index.zero?
      @outputs[index][:type] = :map
      if line.start_with?("%map{")
        @outputs[index][:state] = :ok
      else
        @outputs[index][:state] = :err
        @outputs[index][:msg] = "Start with %map{"
      end
    elsif index.positive? && line.include?("%map{")
      @outputs[index][:state] = :err
      @outputs[index][:type] = :map
      @outputs[index][:msg] = "Write %map on line 0"
    end
  end

  def check_concept(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%concept"

    @outputs[index][:type] = :concept
    @outputs[index][:level] = 1
    @outputs[index][:state] = :ok
    if find_parent(index) != :map
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(map) not found!"
    elsif !line.match(/^\s\s%concept\s*$/)
      binding.break
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 2 spaces before %concept, and no text after"
    end
  end

  def check_names(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%names"

    @outputs[index][:type] = :names
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :concept
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(concept) not found!"
    elsif !line.start_with? "    %names"
    elsif !line.match(/^\s\s\s\s%names\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %names"
    end
  end

  def check_tags(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%tags"

    @outputs[index][:type] = :tags
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if line.strip == "%tags"
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Please, fill with concept tags!"
    elsif find_parent(index) != :concept
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(concept) not found!"
    elsif !line.match(/^\s\s\s\s%tags\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %tags"
    end
  end

  def check_def(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%def"

    @outputs[index][:type] = :def
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :concept
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(concept) not found!"
    elsif !line.match(/^\s\s\s\s%def[\s{]/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %def"
    else
      items = line.strip.split
      if items.size < 2
        @outputs[index][:state] = :err
        @outputs[index][:msg] = "%def has no definition"
      end
    end
  end

  def check_code(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%code"

    @outputs[index][:type] = :code
    @outputs[index][:level] = 1
    @outputs[index][:state] = :ok
    if find_parent(index) != :map
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(map) not found!"
    elsif !line.match(/^\s\s%code\s*$/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 2 spaces before %code, and no text after"
    end
  end

  def check_type(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%type"

    @outputs[index][:type] = :type
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :code
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(code) not found!"
    elsif !line.match(/^\s\s\s\s%type\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %type"
    end
  end

  def check_path(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%path"

    @outputs[index][:type] = :path
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :code
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(code) not found!"
    elsif !line.match(/^\s\s\s\s%path\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %type"
    end
  end

  def check_features(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%features"

    @outputs[index][:type] = :features
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :code
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(code) not found!"
    elsif !line.match(/^\s\s\s\s%features\s*$/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %features, and no text after"
    end
  end

  def check_problem(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%problem"

    @outputs[index][:type] = :problem
    @outputs[index][:level] = 1
    @outputs[index][:state] = :ok
    if find_parent(index) != :map
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(map) not found!"
    elsif !line.match(/^\s\s%problem\s*$/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 2 spaces before %problem, and no text after"
    end
  end

  def check_cases(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%cases"

    @outputs[index][:type] = :cases
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :problem
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(problem) not found!"
    elsif !line.match(/^\s\s\s\s%cases{\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %cases"
    end
  end

  def check_case(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%case "

    @outputs[index][:type] = :case
    @outputs[index][:level] = 3
    @outputs[index][:state] = :ok
    if find_parent(index) != :cases
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(cases) not found!"
    elsif !line.match(/^\s\s\s\s\s\s%case\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 6 spaces before %case"
    end
  end

  def check_desc(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%desc"

    @outputs[index][:type] = :desc
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :problem
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(problem) not found!"
    elsif !line.match(/^\s\s\s\s%desc\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %desc"
    end
  end

  def check_ask(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%ask"

    @outputs[index][:type] = :ask
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :problem
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(problem) not found!"
    elsif !line.match(/^\s\s\s\s%ask/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 4 spaces before %ask"
    end
  end

  def check_text(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%text"

    @outputs[index][:type] = :text
    @outputs[index][:level] = 3
    @outputs[index][:state] = :ok
    if find_parent(index) != :ask
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(ask) not found!"
    elsif !line.match(/^\s\s\s\s\s\s%text\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 6 spaces before %text"
    end
  end

  def check_answer(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%answer"

    @outputs[index][:type] = :answer
    @outputs[index][:level] = 3
    @outputs[index][:state] = :ok
    if find_parent(index) != :ask
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(ask) not found!"
    elsif !line.match(/^\s\s\s\s\s\s%answer[\s|\{type:]/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 6 spaces before %answer, then space or {type:"
    end
  end

  def check_step(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? "%step"

    @outputs[index][:type] = :step
    @outputs[index][:level] = 3
    @outputs[index][:state] = :ok
    if find_parent(index) != :ask
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Parent(ask) not found!"
    elsif !line.match(/^\s\s\s\s\s\s%step\s/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "Write 6 spaces before %step"
    end
  end

  def check_unknown(line, index)
    return unless @outputs[index][:state] == :none

    @outputs[index][:type] = :unknown
    @outputs[index][:level] = count_spaces(line) / 2
    @outputs[index][:state] = :err
    @outputs[index][:msg] = "Unknown tag with parent(#{find_parent(index)})!"
  end

  def find_parent(index)
    current_level = @outputs[index][:level]
    return :noparent if current_level.zero?

    i = index - 1
    while i >= 0
      return @outputs[i][:type] if @outputs[i][:level] == current_level - 1

      i -= 1
    end
    :noparent
  end

  def count_spaces(line)
    a = line.split("%")
    a[0].count(" ")
  end
end
