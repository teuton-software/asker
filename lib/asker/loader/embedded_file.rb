
# Methods to load embedded files defined into asker input data file
# Example:
# %def{:type => :image_url} https://...
# %def{:type => :file} file/host.txt
module EmbeddedFile
  def self.load(filename, localdir)
    if filename.start_with?('https://') || filename.start_with?('http://')
      return "<img src=\"#{filename}\" alt=\"image\" width=\"400\" height=\"300\">"
    end
    # Load content from TXT file
    filename = File.join(localdir, value.text.strip)
    if File.exist? filename
      return "<pre>#{File.read(filename)}</pre>"
    end
    Logger.verbose Rainbow("[ERROR] Unknown file! #{filename}").red.bright
  end
end
