
class ConceptHtmlFormatter

  def initialize(concept)
    @concept = concept
  end

  def to_s
    output=""
    output << 'Concept :<input type="text" name="name" value="'+@concept.name+'" /><br/>'
    return output
  end

end
