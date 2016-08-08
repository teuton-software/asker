
require_relative 'concept_html_formatter'

class ConceptsHtmlFormFormatter

  def initialize(concepts)
    @concepts = concepts
  end

  def to_s
    output=""
    output << '<form action="http://formulario.php" method="post">'
    @concepts.each { |concept| output << ConceptHtmlFormatter.new(concept).to_s }
    output << '<input type="submit" value="Save" />'
    output << '</form>'
    return output
  end

end
