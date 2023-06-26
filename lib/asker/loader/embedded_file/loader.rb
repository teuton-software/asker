require "base64"
require_relative "../../logger"
require_relative "type"

module EmbeddedFile
  # Methods to load embedded files defined into asker input data file
  # Examples:
  #   def line with :type = :image_url used to link external file as https://..."
  #   def line with :type = :file used to load local file as image.png or file.txt"
  class Loader
    ##
    # @param value (String)
    # @param localdir (String) Input file base folder
    # @return Hash
    def call(value, localdir)
      filepath = File.join(localdir, value)
      type = EmbebbedFile::Type.new.for(value, localdir)

      case type
      when :image
        return load_image(value, localdir)
      when :image_url
        return load_image_url(value, localdir)
      when :audio
        return load_audio(value, localdir)
      when :audio_url
        return load_audio_url(value, localdir)
      when :video
        return load_video(value, localdir)
      when :video_url
        return load_video_url(value, localdir)
      end

      {text: "<pre>#{File.read(filepath)}</pre>", file: :none, type: :text}
    end

    def load_audio(value, localdir)
      filepath = File.join(localdir, value)
      output = {}
      output[:text] = '<audio controls><source src="@@PLUGINFILE@@/' + File.basename(filepath) \
                      + '">Your browser does not support the audio tag.</audio>'
      output[:file] = '<file name="' + File.basename(filepath) \
                      + '" path="/" encoding="base64">' \
                      + Base64.strict_encode64(File.open(filepath, "rb").read) \
                      + "</file>"
      output[:type] = :audio
      output
    end

    def load_audio_url(value, localdir)
      {
        text: "<audio src=\"#{value}\" controls></audio>",
        file: :none,
        type: :url
      }
    end

    def load_image(value, localdir)
      filepath = File.join(localdir, value)
      output = {}
      output[:text] = '<img src="@@PLUGINFILE@@/' + File.basename(filepath) \
                      + '" alt="imagen" class="img-responsive atto_image_button_text-bottom">'
      output[:file] = '<file name="' + File.basename(filepath) \
                      + '" path="/" encoding="base64">' \
                      + Base64.strict_encode64(File.open(filepath, "rb").read) \
                      + "</file>"
      output[:type] = :image
      output
    end

    def load_image_url(value, localdir)
      {
        text: "<img src=\"#{value}\" alt=\"image\" width=\"400\" height=\"300\">",
        file: :none,
        type: :url
      }
    end

    def load_video(value, localdir)
      filepath = File.join(localdir, value)
      output = {}
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

    def load_video_url(value, localdir)
      {
        text: "<video controls width=\"400\" height=\"300\">" \
                        + "<source src=\"#{value}\"/></video>",
        file: :none,
        type: :url
      }
    end
  end
end
