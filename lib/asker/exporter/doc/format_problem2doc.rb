class FormatProblem2Doc
  def initialize(problem)
    @problem = problem
  end

  def call
    # attr_accessor :varnames
    # attr_accessor :cases
    out = ""
    title = "Problem: #{@problem.name}"
    out << ("-" * title.size + "\n")
    out << "#{title}\n"
    desc = replace_case_values(@problem.desc)
    out << "#{desc}\n"
    @problem.asks.each_with_index do |ask, index|
      text = replace_case_values(ask[:text])
      out << "#{index + 1}) #{text}\n"
      if ask[:answer]
        answer = replace_case_values(ask[:answer])
        out << "   #{answer}\n"
      else
        ask[:steps].each do |step|
          step = replace_case_values(step)
          out << "   #{step}\n"
        end
      end
    end
    out << "\n"
    out << "\n"
    out
  end

  private

  def replace_case_values(text)
    output = text.clone
    keyvalues = @problem.varnames.zip @problem.cases[0]
    keyvalues.each { |varname, value | output.gsub!(varname, value) }
    output
  end
end
