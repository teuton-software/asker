
class MapHtmlFormatter

  def initialize(lang, context)
    @lang    = lang
    @context = context
  end

  def to_s
    output= <<-ENDRESPONSE
    Version : 1</br>
    Lang    : <input type="text" size=4  name="lang"    value="#{@lang.lang.to_s}" /></br>
    Context : <input type="text" size=50 name="context" value="#{@context.join(",").to_s}" /></br>
    <hr>
    ENDRESPONSE
    return output
  end

end
