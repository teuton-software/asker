# frozen_string_literal: true

require 'base64'

# Methods to load embedded files defined into asker input data file
# Example:
# %def{:type => :image_url} https://...
# %def{:type => :file} file/host.txt
module EmbeddedFile
  ##
  # @param value (String)
  # @param localdir (String) Input file base folder
  # @return Hash
  # rubocop:disable Metrics/MethodLength
  def self.load(value, localdir)
    # When filename is an URL
    if value.start_with?('https://') || value.start_with?('http://')
      return { text: "<img src=\"#{value}\" alt=\"image\" width=\"400\" height=\"300\">", file: :none }
    end

    filepath = File.join(localdir, value)
    unless File.exist?(filepath)
      # When filename is unkown!
      Logger.verbose Rainbow("[ERROR] Unknown file! #{filepath}").red.bright
      exit 1
    end
    # When filename is PNG, JPG o JPEG
    if ['.png', '.jpg', '.jpeg'].include? File.extname(filepath)
      # converts image into base64 strings
      text = '<img src="@@PLUGINFILE@@/' + File.basename(filepath) + '" alt="imagen" class="img-responsive atto_image_button_text-bottom">'
      data = '<file name="' + File.basename(filepath) + '" path="/" encoding="base64">' + Base64.strict_encode64(File.open(filepath, 'rb').read) + '</file>'

      return { text: text, file: data }
    end
    # Suposse that filename is TXT file
    return { text: "<pre>#{File.read(filepath)}</pre>", file: :none } if File.exist?(filepath)
  end
  # rubocop:enable Metrics/MethodLength
end
