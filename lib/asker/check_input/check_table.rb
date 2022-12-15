
module CheckTable

  def check_table(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%table'

    @outputs[index][:type] = :table
    @outputs[index][:level] = 2
    @outputs[index][:state] = :ok
    if find_parent(index) != :concept
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(concept) not found!'
    elsif !line.match(/^\s\s\s\s%table\s*/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 4 spaces before %table'
    end

    unless line.include? "%table{"
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "table must be next to { (Without spaces)"
    end

    unless line.include? "fields:"
      @outputs[index][:state] = :err
      @outputs[index][:msg] = "fields must be next to : (Without spaces)"
    end
  end

  def check_row(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%row'

    @outputs[index][:type] = :row
    @outputs[index][:state] = :ok

    case count_spaces(line)
    when 6
      @outputs[index][:level] = 3
      parent = find_parent(index)
      unless %i[table features].include? parent
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(table/features) not found!'
      end
    when 8
      @outputs[index][:level] = 4
      if find_parent(index) != :template
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(template) not found!'
      end
    else
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 6 or 8 spaces before %row'
    end
  end

  def check_col(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%col'

    @outputs[index][:type] = :col
    @outputs[index][:state] = :ok
    case count_spaces(line)
    when 8
      @outputs[index][:level] = 4
      if find_parent(index) != :row
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(row) not found!'
      end
    when 10
      @outputs[index][:level] = 5
      if find_parent(index) != :row
        @outputs[index][:state] = :err
        @outputs[index][:msg] = 'Parent(row) not found!'
      end
    else
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 8 or 10 spaces before %col'
    end
    check_text(line, index)
  end

  def check_text(line, index)
    return unless @outputs[index][:state] == :ok

    ok = ''
    %w[< >].each do |char|
      ok = char if line.include? char
    end
    return if ok == ''

    @outputs[index][:state] = :err
    @outputs[index][:msg] = "Char #{ok} not allow!"
  end

  def check_template(line, index)
    return unless @outputs[index][:state] == :none
    return unless line.include? '%template'

    @outputs[index][:type] = :template
    @outputs[index][:level] = 3
    @outputs[index][:state] = :ok
    if find_parent(index) != :table
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Parent(concept) not found!'
    elsif !line.match(/^\s\s\s\s\s\s%template\s*/)
      @outputs[index][:state] = :err
      @outputs[index][:msg] = 'Write 6 spaces before %template'
    end
  end
end
