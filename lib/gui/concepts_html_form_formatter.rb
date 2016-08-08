
require_relative 'map_html_formatter'
require_relative 'concept_html_formatter'

class ConceptsHtmlFormFormatter

  def initialize(concepts)
    @concepts = concepts
    @lang     = concepts[0].lang
    @context  = concepts[0].context
  end

  def to_s
    output=""
    output << '<form action="http://formulario.php" method="post">'
    output << MapHtmlFormatter.new(@lang, @context).to_s
    @concepts.each { |concept| output << ConceptHtmlFormatter.new(concept).to_s }
    output << '<input type="submit" value="Save" />'
    output << '</form>'
    return output
  end

end
