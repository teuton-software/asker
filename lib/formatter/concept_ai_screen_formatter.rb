
require 'terminal-table'

class ConceptAIScreenFormatter

  def initialize(concepts_ai)
    @concepts_ai = concepts_ai
  end

  def export
	  project=Project.instance
    return if project.show_mode==:none
    export_notes

    total_q=total_e=total_c=0
    total_sd=total_sb=total_sc=total_sf=total_si=total_ss=0

    my_screen_table = Terminal::Table.new do |st|
      st << ['Concept','Questions','Entries','xFactor','d','b','c','f','i','s']
      st << :separator
    end

    @concepts_ai.each do |concept_ai|
      if concept_ai.process?
        e = concept_ai.texts.size
        concept_ai.tables.each { |t| e = e+t.data[:fields].size*t.data[:rows].size }

        sd = concept_ai.questions[:stage_d].size
        sb = concept_ai.questions[:stage_b].size
        sc = concept_ai.questions[:stage_c].size
        sf = concept_ai.questions[:stage_f].size
        si = concept_ai.questions[:stage_i].size
        ss = concept_ai.questions[:stage_s].size
        t = sd+sb+sc+sf+si+ss

        if e==0 then
          factor="Unkown"
        else
          factor=(t.to_f/e.to_f).round(2).to_s
        end
        my_screen_table.add_row [Rainbow(concept_ai.name).color(:green), t, e, factor, sd, sb, sc, sf, si, ss]

        total_q+=t; total_e+=e; total_c+=1
        total_sd+=sd; total_sb+=sb; total_sc+=sc; total_sf+=sf; total_si+=si; total_ss+=ss
      end
    end

    my_screen_table.add_separator
    my_screen_table.add_row [ Rainbow("TOTAL = #{total_c.to_s}").bright,Rainbow(total_q.to_s).bright,Rainbow(total_e.to_s).bright,Rainbow((total_q.to_f/total_e.to_f).round(2)).bright, total_sd, total_sb, total_sc, total_sf, total_si, total_ss ]
    project.verbose my_screen_table.to_s+"\n"

  end

private

  def export_notes
    project=Project.instance
    project.verbose "\n[INFO] Showing concept stats...\n"
    project.verbose " * Annotations:"
    project.verbose "   ├── (d) Definitions     => Concept.def"
    project.verbose "   ├── (b) Table Matching "
    project.verbose "   ├── (c) Table Rows&Cols "
    project.verbose "   ├── (f) Tables 1 Field  => Concept.table.fields.size==1"
    project.verbose "   ├── (i) Images URL      => Concept.def{:type => 'image_url' }"
    project.verbose "   └── (s) Sequences       => Concept.table{ :type => 'sequence' }"
    project.verbose "\n"
  end
end
