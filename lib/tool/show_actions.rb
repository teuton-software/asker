
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
    total_sa=total_sb=total_sc=total_sd=total_se=0

    my_screen_table = Terminal::Table.new do |st|
      st << ['Concept','Questions','Entries','xFactor','a','b','c','d','e']
      st << :separator
    end

    @concepts.each_value do |concept|
      if concept.process?
        e = concept.data[:texts].size
        concept.data[:tables].each { |t| e=e+t.data[:fields].size*t.data[:rows].size }

        if e==0 then
          porcent="Unkown"
        else
          porcent=(concept.num.to_f/e.to_f).round(2).to_s
        end

        sa = concept.questions[:stage_a].size
        sb = concept.questions[:stage_b].size
        sc = concept.questions[:stage_c].size
        sd = concept.questions[:stage_d].size
        se = concept.questions[:stage_e].size
        t = sa+sb+sc+sd+se
        f = (concept.num-t)
        if f!=0 then
          project.verbose( Rainbow("[ERROR] Tool#show_stats: Missing #{f.to_s} questions").red )
        end
        my_screen_table.add_row [Rainbow(concept.name).color(:green),concept.num.to_s,e.to_s, porcent,sa,sb,sc,sd,se]

        total_q+=concept.num
        total_e+=e
        total_c+=1
        total_sa+=sa; total_sb+=sb; total_sc+=sc; total_sd+=sd; total_se+=se
      end
    end
    my_screen_table.add_separator
    my_screen_table.add_row [ Rainbow("TOTAL = #{total_c.to_s}").bright,Rainbow(total_q.to_s).bright,Rainbow(total_e.to_s).bright,Rainbow((total_q.to_f/total_e.to_f).round(2)).bright, total_sa, total_sb, total_sc, total_sd, total_se ]
    project.verbose my_screen_table.to_s+"\n"
  end

end
