
# Methods to load embedded files defined into asker input data file
# Example:
# %def{:type => :image_url} https://...
# %def{:type => :file} file/host.txt
module EmbeddedFile
  def self.load(value, localdir)
    # When filename is an URL
    if value.start_with?('https://') || value.start_with?('http://')
      return "<img src=\"#{value}\" alt=\"image\" width=\"400\" height=\"300\">"
    end
    filepath = File.join(localdir, value)
    # When filename is PNG, JPG o JPEG
    if [ '.png', '.jpg', '.jpeg'].include? File.extname(filepath)
      return "<pre>Loading image #{filepath}</pre>"
    end
    # Suposse that filename is TXT file
    return "<pre>#{File.read(filepath)}</pre>" if File.exist?(filepath)
    # When filename is unkown!
    Logger.verbose Rainbow("[ERROR] Unknown file! #{value}").red.bright
  end
end
