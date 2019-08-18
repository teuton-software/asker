# frozen_string_literal: true

# Contain data information for every field
# Params:
# * +data+ - Data (Text). This is the field content
# * +id+ - Identifier (Integer)
# * +type+ - May be "text", "textfile_path", "textfile_url" or "image_url"
class DataField
  attr_reader :id, :type

  def initialize(data, id, type)
    @data = data
    @id   = id.to_i # TODO: revise where it comes from? Is it unique value?
    @type = type.to_sym
  end

  def get(option = :raw)
    case @type
    when :text
      return get_text(option)
    when :textfile_path
      return get_textfile_path(option)
    when :textfile_url
      return get_textfile_url(option)
    when :image_url
      return get_image_url(option)
    end
    raise ".get: data=#{@data}, type=#{@type}, option=#{option}"
  end

  private

  def get_text(option)
    return to_screen(@data) if option == :screen

    @data
  end

  def get_textfile_path(option)
    case option
    when :raw
      return @data
    when :id
      return "textfile_path.#{@id}"
    when :decorated
      content = File.new(@data).read
      return "<pre>\n#{content}</pre>"
    when :screen
      return to_screen(@data)
    end
    raise ".get_textfile_path: data=#{@data}, type=#{@type}, option=#{option}"
  end

  def get_textfile_url(option)
    case option
    when :raw
      return @data
    when :id
      return "textfile_url.#{@id}"
    when :decorated
      return "<a href=\"#{@data}\">Textfile URL</a>"
    when :screen
      return to_screen(@data)
    end
    raise ".get_textfile_url: data=#{@data}, type=#{@type}, option=#{option}"
  end

  def get_image_url(option)
    case option
    when :raw
      return @data
    when :id
      return "image_url.#{@id}"
    when :decorated
      return "<img src=\"#{@data}\" alt=\"image\">"
    when :screen
      return to_screen(@data)
    end
    raise ".get_image_url: data=#{@data}, type=#{@type}, option=#{option}"
  end

  def to_screen(text)
    return text[0, 7] + '...' + text[-15, 15] if text.size > 25

    text
  end
end
