# frozen_string_literal: true

require 'terminal-table'

# Export Code into Screen
module CodeScreenExporter
  def self.export_all(codes)
    project = Project.instance
    return if project.show_mode == :none || codes.nil? || codes.size.zero?

    total_c = total_q = total_e = 0
    my_screen_table = Terminal::Table.new do |st|
      st << %w[Filename Type Questions Lines xFactor]
      st << :separator
    end

    codes.each do |code|
      next unless code.process?

      e = code.lines.size
      q = code.questions.size
      factor = 'Unkown'
      factor = (q.to_f / e).round(2).to_s unless e.zero?
      my_screen_table.add_row [Rainbow(File.basename(code.filename)).green,
                               code.type,
                               q,
                               e,
                               factor]
      total_c += 1
      total_q += q
      total_e += e
    end

    my_screen_table.add_separator
    my_screen_table.add_row [Rainbow("TOTAL = #{total_c}").bright,
                             ' ',
                             Rainbow(total_q.to_s).bright,
                             Rainbow(total_e.to_s).bright,
                             Rainbow((total_q / total_e.to_f).round(2)).bright]
    return unless total_c.positive?

    project.verboseln "\n[INFO] Showing CODE statistics"
    project.verboseln my_screen_table.to_s
  end
end
