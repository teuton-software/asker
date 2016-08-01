
require 'terminal-table'

class ConceptIAScreenFormatter

  def initialize(concepts_ia)
    @concepts_ia = concepts_ia
  end

  def export
	  project=Project.instance
    return if project.show_mode==:none

    project.verbose "\n[INFO] Showing concept stats...\n"
    total_q=total_e=total_c=0
    total_sa=total_sb=total_sc=total_sd=total_se=0

    my_screen_table = Terminal::Table.new do |st|
      st << ['Concept','Questions','Entries','xFactor','a','b','c','d','e']
      st << :separator
    end

    @concepts_ia.each do |concept_ia|
      if concept_ia.process?
        e = concept_ia.texts.size
        concept_ia.tables.each { |t| e = e+t.data[:fields].size*t.data[:rows].size }

        sa = concept_ia.questions[:stage_a].size
        sb = concept_ia.questions[:stage_b].size
        sc = concept_ia.questions[:stage_c].size
        sd = concept_ia.questions[:stage_d].size
        se = concept_ia.questions[:stage_e].size
        t = sa+sb+sc+sd+se

        if e==0 then
          factor="Unkown"
        else
          factor=(t.to_f/e.to_f).round(2).to_s
        end
        my_screen_table.add_row [Rainbow(concept_ia.name).color(:green), t, e, factor, sa, sb, sc, sd, se]

        total_q+=t; total_e+=e; total_c+=1
        total_sa+=sa; total_sb+=sb; total_sc+=sc; total_sd+=sd; total_se+=se
      end
    end

    my_screen_table.add_separator
    my_screen_table.add_row [ Rainbow("TOTAL = #{total_c.to_s}").bright,Rainbow(total_q.to_s).bright,Rainbow(total_e.to_s).bright,Rainbow((total_q.to_f/total_e.to_f).round(2)).bright, total_sa, total_sb, total_sc, total_sd, total_se ]
    project.verbose my_screen_table.to_s+"\n"
  end

end
