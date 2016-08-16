
require 'net/http'
require 'uri'

module ImageUrlLoader

  def self.load(input=[])
    filters = []
    if input.class==String then
      filters << input
    end
    #Search Image URLs from Google site, selected by <filters>
    search_url="https://www.google.es/search?q=#{filters.join("+").to_s}&source=lnms&tbm=isch&sa=X&ved=0ahUKEwie9ruF5KLOAhXCOBQKHY-QBTcQ_AUICCgB&biw=1366&bih=643"
    uri = URI.parse(search_url)
    response = Net::HTTP.get_response(uri)

    image_urls = []
    r = response.body.split(" ")
    r.each do |line|
      if line.include? "src=\"https"
        image_urls << line.gsub("\"","")[ 4, line.size]
      end
    end
  return image_urls
  end

end
