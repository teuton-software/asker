require "terminal-table"
require_relative "../logger"

module ProblemDisplayer
  ##
  # Show all "problem" data on screen
  # @param problems (Array) List of "problems" data
  def self.show(problems)
    return if problems.nil? || problems.size.zero?

    total_p = total_q = total_e = 0
    my_screen_table = Terminal::Table.new do |st|
      st << %w[Problem Questions Entries xFactor]
      st << :separator
    end

    problems.each do |problem|
      next unless problem.process?

      e = 0
      problem.asks.each do |ask|
        e += ask[:steps].size
        e += 1 if !ask[:answer].nil?
      end
      q = problem.questions.size
      factor = 'Unkown'
      factor = (q.to_f / e).round(2).to_s unless e.zero?
      desc = Rainbow(problem.desc[0,50]).green
      my_screen_table.add_row [desc, q, e, factor]
      total_p += 1
      total_q += q
      total_e += e
    end
    return unless total_p.positive?

    my_screen_table.add_separator
    my_screen_table.add_row [Rainbow("TOTAL = #{total_p}").bright,
                             Rainbow(total_q.to_s).bright,
                             Rainbow(total_e.to_s).bright,
                             Rainbow((total_q / total_e.to_f).round(2)).bright]
    Logger.verboseln "\n[INFO] Showing PROBLEM statistics"
    Logger.verboseln my_screen_table.to_s
  end
end
