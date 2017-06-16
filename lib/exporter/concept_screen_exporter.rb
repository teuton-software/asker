
require_relative '../formatter/concept_string_formatter'

module ConceptScreenExporter
  def self.export(concepts)
	  project=Project.instance
    return if project.show_mode==:none
    project.verbose "\n[INFO] Showing concept data <#{Rainbow(project.show_mode.to_s).bright}>"

    case project.show_mode
    when :resume
	    s="* Concepts (" + concepts.count.to_s+"): "
	    concepts.each { |c| s=s+c.name+", " }
	    project.verbose s
    when :default
      # Only show Concepts with process attr true
	    concepts.each do |c|
        project.verbose ConceptStringFormatter.new(c).to_s if c.process?
      end
	  end
  end
end
