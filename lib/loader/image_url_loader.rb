
require 'net/http'
require 'uri'
require_relative '../project'

module ImageUrlLoader

  def self.load(input=[])
    filters = []
    if input.class==String then
      i = input.clone
      r = [ ["á","a"], ["é","e"], ["í","i"], ["ó","o"], ["ú","u"], ["ñ","n"], ]
      r.each { |item| i.gsub!(item[0], item[1]) }
      r = [ "-", "_", "," ]
      r.each { |item| i.gsub!(item, " ")}
      filters += i.split(" ")
    elsif input.class==Array then
      filters = input.clone
      filters.flatten!
    else
      raise "[ERROR] ImageUrlLoader: Unkown type #{input.class.to_s}"
    end
    #Search Image URLs from Google site, selected by <filters>
    search_url="https://www.google.es/search?q=#{filters.join("+").to_s}&source=lnms&tbm=isch&sa=X&ved=0ahUKEwie9ruF5KLOAhXCOBQKHY-QBTcQ_AUICCgB&biw=1366&bih=643"
    image_urls = []
    begin
      uri = URI.parse(search_url)
      response = Net::HTTP.get_response(uri)

      r = response.body.split(" ")
      r.each do |line|
        if line.include? "src=\"https"
          image_urls << line.gsub("\"","")[ 4, line.size]
        end
      end
    rescue
      Project.instance.verbose "[ERROR] ImageUrlLoader: #{search_url}"
    end
  return image_urls
  end

end
