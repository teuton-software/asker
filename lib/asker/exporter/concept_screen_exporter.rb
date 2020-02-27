
require_relative '../formatter/concept_string_formatter'
require_relative '../logger'

# Show Concept Data on screen
module ConceptScreenExporter
  ##
  # Show concepts on screen
  # @param concepts (Array)
  # @param show_mode (Symbol)
  def self.export_all(concepts, show_mode = :default)
    return if show_mode == :none
    msg = "\n[INFO] Showing concept data (#{Rainbow(show_mode).bright})"
    Logger.verbose msg
    case show_mode
    when :resume
      s = "* Concepts (#{concepts.count}): "
      concepts.each { |c| s += c.name + ', ' }
      Logger.verbose s
    when :default
      # Only show Concepts with process attr true
      concepts.each do |c|
        Logger.verbose ConceptStringFormatter.to_s(c) if c.process?
      end
    end
  end
end
