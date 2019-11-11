
require_relative '../formatter/concept_string_formatter'

# Show Concept Data on screen
module ConceptScreenExporter
  def self.export_all(concepts)
    project = Project.instance
    return if project.show_mode == :none
    msg = "\n[INFO] Showing concept data <"
    msg += Rainbow(project.show_mode.to_s).bright + '>'
    project.verbose msg

    case project.show_mode
    when :resume
      s = "* Concepts (#{concepts.count}): "
      concepts.each { |c| s += c.name + ', ' }
      project.verbose s
    when :default
      # Only show Concepts with process attr true
      concepts.each do |c|
        project.verbose ConceptStringFormatter.to_s(c) if c.process?
      end
    end
  end
end
