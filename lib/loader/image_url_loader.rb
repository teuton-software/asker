
require 'net/http'
require 'uri'
require_relative '../project'

module ImageUrlLoader

  def self.load(input=[])
    filters = []
    if input.class==String then
      filters += sanitize_string( input.clone )
      filters.flatten!
    elsif input.class==Array then
      filters = sanitize_array( input.clone )
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

  def self.sanitize_string(input)
    r = [ ["á","a"], ["é","e"], ["í","i"], ["ó","o"], ["ú","u"], ["ñ","n"], ]
    r.each { |item| input.gsub!(item[0], item[1]) }
    r = [ "-", "_", ",", "\"" ]
    r.each { |item| input.gsub!(item, " ")}
    return input.split(" ")
  end

  def self.sanitize_array(input)
    output = input.map { |i| sanitize_string(i) }
  end

end
