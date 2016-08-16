
require_relative '../loader/image_url_loader'

class World
  attr_reader :concepts, :filenames, :contexts

  def initialize(concepts)
    @concepts = []
    @filenames = []
    @contexts = []
    @image_urls = {}
    concepts.each do |concept|
      @concepts << concept.name
      @image_urls[concept.name] = ImageUrlLoader::load( concept.name )
      @filenames << concept.filename
      @contexts << concept.context
    end
  end

end
