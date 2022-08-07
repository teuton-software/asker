
require 'base64'

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
    # When filename is an URL
    if value.start_with?('https://') || value.start_with?('http://')
      if is_image? value
        html_text = "<img src=\"#{value}\" alt=\"image\" width=\"400\" height=\"300\">"
      elsif is_audio? value
        html_text = "<audio src=\"#{value}\" controls></audio>"
      else
        html_text = "<b> #{value}: Unkown file type!</b>"
      end
      return { text: html_text, file: :none }
    end

    filepath = File.join(localdir, value)
    unless File.exist?(filepath)
      # When filename is unkown!
      Logger.verbose Rainbow("[ERROR] Unknown file! #{filepath}").red.bright
      exit 1
    end
    if is_image? filepath
      text = '<img src="@@PLUGINFILE@@/' + File.basename(filepath) \
             + '" alt="imagen" class="img-responsive atto_image_button_text-bottom">'
      data = '<file name="' + File.basename(filepath) + '" path="/" encoding="base64">' \
             + Base64.strict_encode64(File.open(filepath, 'rb').read) + '</file>'
      return { text: text, file: data }
    elsif is_audio? filepath
      text = '<audio controls><source src="@@PLUGINFILE@@/' + File.basename(filepath) \
             + '">Your browser does not support the audio tag.</audio>'
      data = '<file name="' + File.basename(filepath) + '" path="/" encoding="base64">' \
             + Base64.strict_encode64(File.open(filepath, 'rb').read) + '</file>'
      return { text: text, file: data }
    elsif is_video? filepath
      text = '<video controls><source src="@@PLUGINFILE@@/' + File.basename(filepath) \
             + '">Your browser does not support the video tag.</video>'
      data = '<file name="' + File.basename(filepath) + '" path="/" encoding="base64">' \
             + Base64.strict_encode64(File.open(filepath, 'rb').read) + '</file>'
      return { text: text, file: data }
    end
    # Suposse that filename is TXT file
    return { text: "<pre>#{File.read(filepath)}</pre>", file: :none } if File.exist?(filepath)

    { text: :error, file: :none}
  end

  def self.is_audio?(filename)
    extens = ['.mp3', '.ogg', '.wav']
    extens.each {|ext| return true if filename.downcase.end_with?(ext) }
    false
  end

  def self.is_image?(filename)
    extens = ['.jpg', '.jpeg', '.png']
    extens.each {|ext| return true if filename.downcase.end_with?(ext) }
    false
  end

  def self.is_video?(filename)
    extens = ['.mp4', '.ogv']
    extens.each {|ext| return true if filename.downcase.end_with?(ext) }
    false
  end

  def self.load_image(value, localdir)
    output = { text: :error, file: :none, type: :image}

    if value.start_with?('https://') || value.start_with?('http://')
      output[:text] = "<img src=\"#{value}\" alt=\"image\" width=\"400\" height=\"300\">"
      output[:file] = ''
      return output
    end

    filepath = File.join(localdir, value)
    unless File.exist?(filepath)
      Logger.verbose Rainbow("[ERROR] Unknown file! #{filepath}").red.bright
      exit 1
    end
    output[:text] = '<img src="@@PLUGINFILE@@/' + File.basename(filepath) \
                    + '" alt="imagen" class="img-responsive atto_image_button_text-bottom">'
    output[:file] = '<file name="' + File.basename(filepath) \
                    + '" path="/" encoding="base64">' \
                    + Base64.strict_encode64(File.open(filepath, 'rb').read) + '</file>'
    output
  end

end
