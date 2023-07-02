require "terminal-table"
require_relative "../logger"

class ProblemDisplayer
  ##
  # Show all "problem" data on screen
  # @param problems (Array) List of "problems" data
  def call(problems)
    return if problems.nil? || problems.size.zero?

    total_p = total_q = total_e = total_a = total_s = 0
    my_screen_table = Terminal::Table.new do |st|
      st << %w[Problem Desc Questions Entries xFactor a s]
      st << :separator
    end

    problems.each do |problem|
      next unless problem.process?

      e = problem.cases.size
      problem.asks.each do |ask|
        e += ask[:steps].size
        e += 1 if !ask[:answer].nil?
      end

      desc = Rainbow(problem.desc[0, 24]).green
      q = problem.questions.size
      factor = "Unknown"
      factor = (q.to_f / e).round(2).to_s unless e.zero?
      a = problem.stats[:answer]
      s = problem.stats[:steps]

      my_screen_table.add_row [problem.name, desc, q, e, factor, a, s]
      total_p += 1
      total_q += q
      total_e += e
      total_a += a
      total_s += s
    end
    return unless total_p.positive?

    my_screen_table.add_separator
    my_screen_table.add_row [Rainbow("TOTAL = #{total_p}").bright, "",
      Rainbow(total_q.to_s).bright,
      Rainbow(total_e.to_s).bright,
      Rainbow((total_q / total_e.to_f).round(2)).bright,
      Rainbow(total_a.to_s).bright,
      Rainbow(total_s.to_s).bright]
    Logger.verboseln Rainbow("\n[INFO] Showing PROBLEMs statistics").white
    Logger.verboseln my_screen_table.to_s
  end
end
