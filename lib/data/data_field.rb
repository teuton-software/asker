
class DataField

  def initialize(data, id, type)
    @data = data
    @id   = id
    @type = type
  end

  def get(option=:raw)
    case @type
    when "text"
      return get_text(option)
    when "textfile_url"
      return get_textfile_url(option)
    when "image_url"
      return get_image_url(option)
    else
      raise "[ERROR] DataField.get: data=#{@data}, type=#{@type}, option=#{option}"
    end
  end

private

  def get_text(option)
    return @data
  end

  def get_textfile_url(option)
    case option
    when :raw
      return @data
    when :id
      return "textfile_url.#{@id.to_s}"
    when :decorated
      return "<a href=\"#{@data}\">textfile_url.#{@id.to_s}</a>"
    else
      raise "[ERROR] DataField.get_textfile_url: data=#{@data}, type=#{@type}, option=#{option}"
    end
  end

  def get_image_url(option)
    case option
    when :raw
      return @data
    when :id
      return "image_url.#{@id.to_s}"
    when :decorated
      return "<img src=\"#{@data}\" alt=\"image\">"
    else
      raise "[ERROR] DataField.get_image_url: data=#{@data}, type=#{@type}, option=#{option}"
    end
  end

end
