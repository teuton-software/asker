class FormatProblem2Doc
  def call(problem)
    # attr_accessor :varnames
    # attr_accessor :cases
    out = ""
    title = "Problem: #{problem.name}"
    out << ("-" * title.size + "\n")
    out << "#{title}\n"
    out << "#{problem.desc}\n"
    problem.asks.each_with_index do |ask, index|
      out << "#{index + 1}) #{ask[:text]}\n"
      if ask[:answer]
        out << "   #{ask[:answer]}\n"
      else
        ask[:steps].each do |step|
          out << "   #{step}\n"
        end
      end
    end
    out << "\n"
    out << "\n"
    out
  end
end
