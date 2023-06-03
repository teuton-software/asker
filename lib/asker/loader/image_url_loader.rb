require "net/http"
require "uri"
require_relative "../logger"

# Search URL images on Internet
# Methods:
# * +load+ - Accept String or an Array with the desired search
# * +sanitize_string+ - Clean URL string
# * +sanitize_array+ - Clean URL Array
module ImageUrlLoader
  # Search "input" images on Google and return URL
  def self.load(input = [])
    filters = []
    if input.instance_of? String
      filters += sanitize_string(input.clone)
    elsif input.instance_of? Array
      filters = sanitize_array(input.clone)
    else
      Logger.error "ImageUrlLoader: Unkown type (#{input.class})"
      exit 1
    end
    # Search Image URLs from Google site, selected by <filters>
    search_url = "https://www.google.es/search?q="
    search_url << filters.flatten.join("+").to_s
    search_url << "&source=lnms&tbm=isch&sa=X&ved=2ahUKEwj_g8Wfst7nAhWpzoUKHf_wDbsQ_AUoAnoECBMQBA&biw=1280&bih=591"
    image_urls = []
    begin
      uri = URI.parse(search_url)
      response = Net::HTTP.get_response(uri)

      r = response.body.split(" ")
      r.each do |line|
        if line.include? 'src="https'
          image_urls << line.delete('"')[4, line.size]
        end
      end
    rescue
      Logger.warn "ImageUrlLoader: Problems with URL (#{search_url})"
      Logger.warn "                (a) Check Internet connections"
      Logger.warn "                (b) Ensure URL is well formed"
    end
    image_urls
  end

  def self.sanitize_string(input)
    text = input.dup
    r = [
      %w[á a], %w[é e], %w[í i], %w[ó o], %w[ú u], %w[ñ n],
      %w[Á A], %w[É E], %w[Í I], %w[Ó O], %w[Ú U], %w[Ñ N]
    ]
    r.each { |item| text.gsub!(item[0], item[1]) }
    r = %w[- _ , "]
    r.each { |item| text.gsub!(item, " ") }
    text.split(" ")
  end

  def self.sanitize_array(input)
    input.map { |i| sanitize_string(i) }
  end
end
