
require 'terminal-table'

module CodeScreenExporter
  def self.export(fobs)
	  project = Project.instance
    return if project.show_mode == :none || fobs.nil? || fobs.size == 0

    total_f = total_q = total_e = 0

    my_screen_table = Terminal::Table.new do |st|
      st << ['Filename','Type','Questions','Lines','xFactor']
      st << :separator
    end

    fobs.each do |fob|
      if fob.process?
        e = fob.lines.size
        q = fob.questions.size

        if e == 0 then
          factor = 'Unkown'
        else
          factor = (q.to_f/e.to_f).round(2).to_s
        end
        my_screen_table.add_row [Rainbow(File.basename(fob.filename)).green, fob.type, q, e, factor]

        total_f += 1; total_q += q; total_e += e
      end
    end

    my_screen_table.add_separator
    my_screen_table.add_row [Rainbow("TOTAL = #{total_f.to_s}").bright, ' ', Rainbow(total_q.to_s).bright, Rainbow(total_e.to_s).bright,Rainbow((total_q.to_f/total_e.to_f).round(2)).bright]
    project.verbose my_screen_table.to_s + "\n"
  end
end
