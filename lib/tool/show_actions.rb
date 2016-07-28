#!/usr/bin/ruby

require 'terminal-table'

module ShowActions

  def show_data
	  project=Project.instance
    return if project.show_mode==:none

    project.verbose "[INFO] Showing concept data <#{Rainbow(project.show_mode.to_s).bright}>..."

    case project.show_mode
    when :resume
	    s="* Concepts ("+@concepts.count.to_s+"): "
	    @concepts.each_value { |c| s=s+c.name+", " }
	    project.verbose s
    when :default
	    @concepts.each_value { |c| project.verbose c.to_s if c.process? }
	  end
  end

  def show_stats
	  project=Project.instance
    return if project.show_mode==:none
    project.verbose "[INFO] Showing concept stats...\n"
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
    project.verbose my_screen_table.to_s+"\n"
  end

  def show_stage_stats
	  project=Project.instance
    return if project.show_mode==:none
    project.verbose "\n[INFO] Showing concept STAGE stats...\n"

    my_screen_table = Terminal::Table.new do |st|
      st << ['Concept','A','B','C','Total','...', 'num']
      st << :separator
    end

    @concepts.each_value do |concept|
      if concept.process?
        a = concept.questions[:stage_a].size
        b = concept.questions[:stage_b].size
        c = concept.questions[:stage_c].size
        t = a+b+c
        f = (concept.num-t)
        n = concept.num.to_s
        my_screen_table.add_row [Rainbow(concept.name).color(:green),a.to_s, b.to_s, c.to_s, t.to_s, f.to_s, n.to_s]
      end
    end
    project.verbose my_screen_table.to_s+"\n"
  end

end
