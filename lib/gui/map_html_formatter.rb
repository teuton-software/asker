
class MapHtmlFormatter

  def initialize(lang, context)
    @lang    = lang
    @context = context
  end

  def to_list
    output= <<-ENDRESPONSE
    Lang: <input type="text" size=4  name="lang"    value="#{@lang.lang.to_s}" />
    Context: <input type="text" size=60 name="context" value="#{@context.join(",").to_s}" />
    Version: 1</br>
    <hr>
    ENDRESPONSE
    return output
  end

end
