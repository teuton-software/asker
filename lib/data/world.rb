
require_relative '../loader/image_url_loader'

class World
  attr_reader :concepts, :filenames, :contexts, :image_urls

  def initialize(concepts)
    @concepts = []
    @filenames = []
    @contexts = []
    @image_urls = {}
    concepts.each do |concept|
      @concepts << concept.name
      @filenames << concept.filename
      @contexts += concept.context
    end
    @filenames.uniq!
    @contexts.uniq!

    @concepts.each { |concept| @image_urls[concept] = ImageUrlLoader::load(concept) }
    @contexts.each { |context| @image_urls[context] = ImageUrlLoader::load(context) }
  end

end
