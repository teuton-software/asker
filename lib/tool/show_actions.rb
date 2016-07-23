#!/usr/bin/ruby
# encoding: utf-8

require 'terminal-table'

module ShowActions

  def show_data
	  app=Application.instance

    verbose "[INFO] Showing concept data <#{Rainbow(app.show_mode.to_s).bright}>..."

    case app.show_mode
    when :resume
	    s="* Concepts ("+@concepts.count.to_s+"): "
	    @concepts.each_value { |c| s=s+c.name+", " }
	    verbose s
    when :default
	    @concepts.each_value { |c| verbose c.to_s if c.process? }
	  end
  end

  def show_stats
	  app=Application.instance
    return if app.show_mode==:none
    verbose "[INFO] Showing concept stats...\n"
    total_q=total_e=total_c=0

    my_screen_table = Terminal::Table.new do |st|
      st << ['Concept','Questions','Entries','Productivity %']
      st << :separator
    end

    @concepts.each_value do |c|
      if c.process?
        e=c.data[:texts].size
        c.data[:tables].each { |t| e=e+t.data[:fields].size*t.data[:rows].size }

        if e==0 then
          porcent="Unkown"
        else
          porcent=(c.num.to_f/e.to_f*100.0).to_i.to_s+"%"
        end

        my_screen_table.add_row [Rainbow(c.name).color(:green),c.num.to_s,e.to_s, porcent]

        total_q+=c.num
        total_e+=e
        total_c+=1
      end
    end
    my_screen_table.add_separator
    my_screen_table.add_row [ Rainbow("TOTAL = #{total_c.to_s}").bright,Rainbow(total_q.to_s).bright,Rainbow(total_e.to_s).bright,Rainbow((total_q.to_f*100.0/total_e.to_f).to_i).bright ]
    verbose my_screen_table.to_s+"\n"
  end
end
