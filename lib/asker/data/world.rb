
require_relative '../loader/image_url_loader'
require_relative '../project'
require_relative '../logger'

##
# World data
class World
  attr_reader :concepts, :filenames, :contexts, :image_urls

  ##
  # Initialize World object
  # @param concepts (Array)
  # @param show_progress (Boolean)
  def initialize(concepts, show_progress=true)
    find_neighbors_for_every_concept(concepts)
    @concepts, @filenames, @contexts = get_lists_from(concepts)
    @image_urls = find_url_images_from_internet(show_progress)
  end

  def find_neighbors_for_every_concept(concepts)
    concepts.each do |i|
      concepts.each do |j|
        if i.id != j.id
          i.try_adding_neighbor(j)
          i.try_adding_references(j)
        end
      end
    end
  end

  private

  def get_lists_from(input)
    concepts = {}
    filenames = []
    contexts = []

    input.each do |c|
      if c.process
        concepts[c.name] = c
        filenames << c.filename
        contexts  << c.context
      end
    end
    filenames.uniq!
    contexts.uniq!
    return [concepts, filenames, contexts]
  end

  def find_url_images_from_internet(show_progress)
    param = Application.instance.config['global']['internet'] || 'yes'
    return {} unless param == 'yes'

    Logger.verbose "\n[INFO] Loading data from Internet" if show_progress
    threads = []
    searchs = []
    urls = {}

    @concepts.each_key { |key| searchs << key } if @concepts
    @contexts.each { |filter| searchs << filter.join(' ').to_s }
    searchs.each do |search|
      print('.') if show_progress
      threads << Thread.new { urls[search] = ImageUrlLoader.load(search) }
    end
    threads.each(&:join) # wait for all threads to finish
    print("\n") if show_progress
    urls
  end
end
