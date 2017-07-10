
require 'terminal-table'

module CodeScreenExporter
  def self.export(codes)
	  project = Project.instance
    return if project.show_mode == :none || codes.nil? || codes.size == 0

    total_c = total_q = total_e = 0

    my_screen_table = Terminal::Table.new do |st|
      st << ['Filename','Type','Questions','Lines','xFactor']
      st << :separator
    end

    codes.each do |code|
      if code.process?
        e = code.lines.size
        q = code.questions.size

        if e == 0 then
          factor = 'Unkown'
        else
          factor = (q.to_f/e.to_f).round(2).to_s
        end
        my_screen_table.add_row [Rainbow(File.basename(code.filename)).green, code.type, q, e, factor]

        total_c += 1; total_q += q; total_e += e
      end
    end

    my_screen_table.add_separator
    my_screen_table.add_row [Rainbow("TOTAL = #{total_c.to_s}").bright, ' ', Rainbow(total_q.to_s).bright, Rainbow(total_e.to_s).bright,Rainbow((total_q.to_f/total_e.to_f).round(2)).bright]

    if total_c > 0
      project.verboseln "\n[INFO] Showing CODE statistics"
      project.verboseln my_screen_table.to_s
    end
  end
end
