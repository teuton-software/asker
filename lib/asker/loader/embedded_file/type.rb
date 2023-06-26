
module EmbebbedFile
  class Type
    def for(value, localdir)
      if is_url? value
        return :image_url if is_image? value
        return :audio_url if is_audio? value
        return :video_url if is_video? value

        Logger.error "EmbebbedFile::Type.for: Unknown URL type (#{value})"
        exit 1
      end

      filepath = File.join(localdir, value)
      unless File.exist?(filepath)
        Logger.error "EmbeddedFile::Type.for: File does not exist (#{filepath})"
        exit 1
      end

      return :image if is_image? value
      return :audio if is_audio? value
      return :video if is_video? value

      :text
    end

    def is_audio?(filename)
      extens = [".mp3", ".ogg", ".wav"]
      extens.each { |ext| return true if filename.downcase.end_with?(ext) }
      false
    end

    def is_image?(filename)
      extens = [".jpg", ".jpeg", ".png"]
      extens.each { |ext| return true if filename.downcase.end_with?(ext) }
      false
    end

    def is_video?(filename)
      extens = [".mp4", ".ogv"]
      extens.each { |ext| return true if filename.downcase.end_with?(ext) }
      false
    end

    def is_url?(value)
      return true if value.start_with?("https://", "http://")

      false
    end
  end
end
