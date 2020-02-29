require_relative 'concept_ai_screen_exporter'
require_relative 'code_screen_exporter'

# Display Stats on screen.
module StatsScreenExporter
  def self.export(data, show_mode)
    return if show_mode == :none

    # show_final_results
    ConceptAIScreenExporter.export(data[:concepts_ai])
    CodeScreenExporter.export(data[:codes])
  end
end
