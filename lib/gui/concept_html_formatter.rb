
class ConceptHtmlFormatter

  def initialize(concept)
    @concept = concept
  end

  def to_list
    output= <<-ENDRESPONSE
    <li>#{@concept.name} (Show | Edit | Delete)</li>
    ENDRESPONSE
    return output
  end

  def to_show
    output= <<-ENDRESPONSE
    Concept : <b>#{@concept.id}</b><br/>
    <ul>
    <li>Name: <input type="text" name="name" value="#{@concept.name}" /></li>
    <li>Tags: <input type="text" name="tags" value="#{@concept.tags.join(",")}" size=60 /></li>
    <li>Defs: <input type="text" name="defs" value="#{@concept.texts[0].to_s}"  size=60 /></li>
    </ul>
    <hr>
    ENDRESPONSE
    return output
  end

end
