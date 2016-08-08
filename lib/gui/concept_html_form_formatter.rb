
class ConceptHtmlFormFormatter

  def initialize(concept)
    @concept = concept
  end

  def to_s
    output=""
    output << '<form "http://maneja_formulario.php" method="post">'
    output << 'Escribe tu nombre:<input type="text" name="nombre" value="" /><br/>'
    output << '<input type="submit" value="Enviar" />'
    output << '</form>'    
    return output
  end

end
