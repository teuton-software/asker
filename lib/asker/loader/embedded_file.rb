require "base64"
require_relative "../logger"

# Methods to load embedded files defined into asker input data file
# Example:
# * def line with :type = :image_url used to link external file as https://..."
# * def line with :type = :file used to load local file as image.png or file.txt"
module EmbeddedFile
  ##
  # @param value (String)
  # @param localdir (String) Input file base folder
  # @return Hash
  def self.load(value, localdir)
    return load_image(value, localdir) if is_image? value
    return load_audio(value, localdir) if is_audio? value
    return load_video(value, localdir) if is_video? value

    if is_url? value
      Logger.error "[ERROR] EmbebbedFile. Unkown URL: #{value}"
      exit 1
    end

    filepath = File.join(localdir, value)
    unless File.exist?(filepath)
      Logger.error "[ERROR] EmbeddedFile: File does not exist! #{filepath}"
      exit 1
    end

    # Suposse that filename is TEXT file
    {text: "<pre>#{File.read(filepath)}</pre>", file: :none, type: :text}
  end

  def self.is_audio?(filename)
    extens = [".mp3", ".ogg", ".wav"]
    extens.each { |ext| return true if filename.downcase.end_with?(ext) }
    false
  end

  def self.is_image?(filename)
    extens = [".jpg", ".jpeg", ".png"]
    extens.each { |ext| return true if filename.downcase.end_with?(ext) }
    false
  end

  def self.is_video?(filename)
    extens = [".mp4", ".ogv"]
    extens.each { |ext| return true if filename.downcase.end_with?(ext) }
    false
  end

  def self.is_url?(value)
    return true if value.start_with?("https://", "http://")

    false
  end

  def self.load_audio(value, localdir)
    output = {text: :error, file: :none, type: :audio}

    if is_url? value
      output[:text] = "<audio src=\"#{value}\" controls></audio>"
      output[:file] = :none
      output[:type] = :url
      return output
    end

    filepath = File.join(localdir, value)
    unless File.exist?(filepath)
      Logger.error "[ERROR] Audio file no exists!: #{filepath}"
      exit 1
    end
    output[:text] = '<audio controls><source src="@@PLUGINFILE@@/' + File.basename(filepath) \
                    + '">Your browser does not support the audio tag.</audio>'
    output[:file] = '<file name="' + File.basename(filepath) \
                    + '" path="/" encoding="base64">' \
                    + Base64.strict_encode64(File.open(filepath, "rb").read) \
                    + "</file>"
    output[:type] = :audio
    output
  end

  def self.load_image(value, localdir)
    output = {text: :error, file: :none, type: :image}

    if is_url? value
      output[:text] = "<img src=\"#{value}\" alt=\"image\" width=\"400\" height=\"300\">"
      output[:file] = :none
      output[:type] = :url
      return output
    end

    filepath = File.join(localdir, value)
    unless File.exist?(filepath)
      Logger.error "[ERROR] EmbeddedFile: Unknown file! #{filepath}"
      exit 1
    end
    output[:text] = '<img src="@@PLUGINFILE@@/' + File.basename(filepath) \
                    + '" alt="imagen" class="img-responsive atto_image_button_text-bottom">'
    output[:file] = '<file name="' + File.basename(filepath) \
                    + '" path="/" encoding="base64">' \
                    + Base64.strict_encode64(File.open(filepath, "rb").read) \
                    + "</file>"
    output[:type] = :image
    output
  end

  def self.load_video(value, localdir)
    output = {text: :error, file: :none, type: :video}
    if is_url? value
      output[:text] = "<video controls width=\"400\" height=\"300\">" \
                      + "<source src=\"#{value}\"/></video>"
      output[:file] = :none
      output[:type] = :url
      return output
    end

    filepath = File.join(localdir, value)
    unless File.exist?(filepath)
      Logger.error "[ERROR] Unknown file! #{filepath}"
      exit 1
    end
    output[:text] = '<video controls><source src="@@PLUGINFILE@@/' \
                    + File.basename(filepath) \
                    + '"/>Your browser does not support the video tag.</video>'
    output[:file] = '<file name="' \
                    + File.basename(filepath) \
                    + '" path="/" encoding="base64">' \
                    + Base64.strict_encode64(File.open(filepath, "rb").read) \
                    + "</file>"
    output[:type] = :video
    output
  end
end
