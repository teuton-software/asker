
require 'net/http'
require 'uri'
require_relative '../project'
require_relative '../application'

# Search URL images on Internet
# Methods:
# * +load+ - Accept String or an Array with the desired search
# * +sanitize_string+ - Clean URL string
# * +sanitize_array+ - Clean URL Array
module ImageUrlLoader
  # Search "input" imagens on Google and return URL
  def self.load(input = [])
    param = Application.instance.config['global']['internet'] || 'yes'
    return [] unless param == 'yes'

    filters = []
    if input.class == String
      filters += sanitize_string(input.clone)
      filters.flatten!
    elsif input.class == Array
      filters = sanitize_array(input.clone)
      filters.flatten!
    else
      raise "[ERROR] ImageUrlLoader: Unkown type #{input.class}"
    end
    # Search Image URLs from Google site, selected by <filters>
    search_url = 'https://www.google.es/search?q='
    search_url << filters.join('+').to_s
    search_url << '&source=lnms&tbm=isch&sa=X&ved=0ahUKEwie9ruF5KLOAhXCOBQKHY-QBTcQ_AUICCgB&biw=1366&bih=643'

    image_urls = []
    begin
      uri = URI.parse(search_url)
      response = Net::HTTP.get_response(uri)

      r = response.body.split(' ')
      r.each do |line|
        if line.include? 'src="https'
          image_urls << line.delete('"')[4, line.size]
        end
      end
    rescue
      Project.instance.verboseln '[ERROR] ImageUrlLoader'
      Project.instance.verboseln " => #{search_url}"
      Project.instance.verboseln ' => Check Internet connections'
      Project.instance.verboseln ' => Ensure URL is well formed'
    end
    image_urls
  end

  def self.sanitize_string(input)
    r = [ ['á', 'a'], ['é', 'e'], ['í', 'i'], ['ó', 'o'], ['ú', 'u'], ['ñ', 'n'], ['Á', 'A'], ['É', 'E'], ['Í', 'I'], ['Ó', 'O'], ['Ú', 'U'], ['Ñ', 'N']]
    r.each { |item| input.gsub!(item[0], item[1]) }
    r = ['-', '_', ',', '"']
    r.each { |item| input.gsub!(item, ' ') }
    input.split(' ')
  end

  def self.sanitize_array(input)
    input.map { |i| sanitize_string(i) }
  end
end
