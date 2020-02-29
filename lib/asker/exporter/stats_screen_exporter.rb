require_relative 'concept_ai_screen_exporter'
require_relative 'code_screen_exporter'

# Display Stats on screen.
module StatsScreenExporter
  def self.export(data, show_mode)
    # show_final_results
    ConceptAIScreenExporter.export_all(data[:concepts_ai], show_mode)
    CodeScreenExporter.export_all(data[:codes], show_mode)
  end
end
