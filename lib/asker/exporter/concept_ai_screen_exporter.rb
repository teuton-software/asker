# frozen_string_literal: true

require 'terminal-table'

# Show ConceptAI info on screen
class ConceptAIScreenExporter
  def self.export_all(concepts_ai)
    @concepts_ai = concepts_ai
	  project = Project.instance
    return if project.show_mode == :none

    # Create table HEAD
    screen_table = Terminal::Table.new do |st|
      st << ['Concept','Questions','Entries','xFactor',
             'd','b','f','i','s','t']
      st << :separator
    end

    # Create table BODY
    total = {}
    total[:q] = total[:e] = total[:c] = 0
    total[:sd] = total[:sb] = total[:sf] = 0
    total[:si] = total[:ss] = total[:st] = 0

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
        t = sd + sb + sf + si + ss + st

        if e == 0
          factor = 'Unkown'
        else
          factor = (t.to_f/e.to_f).round(2).to_s
        end
        screen_table.add_row [Rainbow(concept_ai.name(:screen)).green.bright,
          t, e, factor, sd, sb, sf, si, ss, st]

        total[:q] += t ; total[:e] += e; total[:c] += 1
        total[:sd] += sd; total[:sb] += sb; total[:sf] += sf
        total[:si] += si; total[:ss] += ss; total[:st] += st
      end
    end
    return if total[:c] == 0 # No concepts to be process?

    # Add row with excluded questions
    export_excluded_questions(screen_table, @concepts_ai)

    # Create table TAIL
    screen_table.add_separator
    screen_table.add_row [Rainbow("TOTAL = #{total[:c]}").bright,
                          Rainbow(total[:q].to_s).bright,
                          Rainbow(total[:e].to_s).bright,
                          Rainbow((total[:q].to_f/total[:e].to_f).round(2)).bright,
                          total[:sd], total[:sb], total[:sf],
                          total[:si], total[:ss], total[:st]]
    export_notes
    project.verbose screen_table.to_s + "\n"
  end

  def self.export_excluded_questions(screen_table, concepts_ai)
    # Create table BODY
    total = {}
    total[:q] = total[:c] = 0
    total[:sd] = total[:sb] = total[:sf] = 0
    total[:si] = total[:ss] = total[:st] = 0

    concepts_ai.each do |concept_ai|
      if concept_ai.process?
        sd = concept_ai.excluded_questions[:d].size
        sb = concept_ai.excluded_questions[:b].size
        sf = concept_ai.excluded_questions[:f].size
        si = concept_ai.excluded_questions[:i].size
        ss = concept_ai.excluded_questions[:s].size
        st = concept_ai.excluded_questions[:t].size
        t = sd + sb + sf + si + ss + st

        total[:q] += t ; total[:c] += 1
        total[:sd] += sd; total[:sb] += sb; total[:sf] += sf
        total[:si] += si; total[:ss] += ss; total[:st] += st
      end
    end
    screen_table.add_row [Rainbow('Excluded questions').yellow.bright,
                          total[:q], '-', '-',
                          total[:sd], total[:sb],
                          total[:sf], total[:si],
                          total[:ss], total[:st]]
  end

  def self.export_notes
    p = Project.instance
    p.verbose "\n[INFO] Showing CONCEPT statistics\n"
    p.verbose ' * Exclude questions: ' +
              Application.instance.config['questions']['exclude'].to_s
    p.verbose ' * Annotations:'
    p.verbose '   ├── (d) Definitions     <= Concept.def'
    p.verbose '   ├── (b) Table Matching  <= ' \
              'Concept.table.rows.columns'
    p.verbose '   ├── (f) Tables 1 Field  <= Concept.table.fields.size==1'
    p.verbose '   ├── (i) Images URL      <= ' \
              "Concept.def{:type => 'image_url'}"
    p.verbose '   ├── (s) Sequences       <= ' \
              "Concept.table{:sequence => '...'}"
    p.verbose '   └── (t) Table Rows&Cols <= ' \
              'Concept.table.rows.columns'
    p.verbose "\n"
  end
end
