
require 'terminal-table'

class ConceptAIScreenExporter

  def self.export(concepts_ai)
    @concepts_ai = concepts_ai
	  project = Project.instance
    return if project.show_mode == :none

    total_q=total_e=total_c=0
    total_sd=total_sb=total_sf=total_si=total_ss=total_st=0

    my_screen_table = Terminal::Table.new do |st|
      st << ['Concept','Questions','Entries','xFactor','d','b','f','i','s','t']
      st << :separator
    end

    @concepts_ai.each do |concept_ai|
      if concept_ai.process?
        e = concept_ai.texts.size
        concept_ai.tables.each { |t| e += t.fields.size * t.rows.size }

        sd = concept_ai.questions[:d].size
        sb = concept_ai.questions[:b].size
        sf = concept_ai.questions[:f].size
        si = concept_ai.questions[:i].size
        ss = concept_ai.questions[:s].size
        st = concept_ai.questions[:t].size
        t = sd+sb+sf+si+ss+st

        if e == 0
          factor = 'Unkown'
        else
          factor = (t.to_f/e.to_f).round(2).to_s
        end
        my_screen_table.add_row [Rainbow(concept_ai.name(:screen)).color(:green), t, e, factor, sd, sb, sf, si, ss, st]

        total_q+=t; total_e+=e; total_c+=1
        total_sd+=sd; total_sb+=sb; total_sf+=sf; total_si+=si; total_ss+=ss; total_st+=st
      end
    end

    return if total_c == 0
    my_screen_table.add_separator
    my_screen_table.add_row [ Rainbow("TOTAL = #{total_c.to_s}").bright,Rainbow(total_q.to_s).bright,Rainbow(total_e.to_s).bright,Rainbow((total_q.to_f/total_e.to_f).round(2)).bright, total_sd, total_sb, total_sf, total_si, total_ss, total_st ]
    export_notes
    project.verbose my_screen_table.to_s+"\n"

  end

  def self.export_notes
    project = Project.instance
    project.verbose "\n[INFO] Showing CONCEPT statistics\n"
    project.verbose ' * Annotations:'
    project.verbose '   ├── (d) Definitions     => Concept.def'
    project.verbose "   ├── (b) Table Matching "
    project.verbose "   ├── (f) Tables 1 Field  => Concept.table.fields.size==1"
    project.verbose "   ├── (i) Images URL      => Concept.def{:type => 'image_url'}"
    project.verbose "   ├── (s) Sequences       => Concept.table{:sequence => '...'}"
    project.verbose "   └── (t) Table Rows&Cols => Concept.tables.rows.columns"
    project.verbose "\n"
  end
end
