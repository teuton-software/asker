# frozen_string_literal: true

require_relative '../loader/image_url_loader'
require_relative '../logger'

class World
  attr_reader :concepts, :filenames, :contexts, :image_urls

  def initialize(concepts, show_progress = true)
    find_neighbors_for_every_concept(concepts)
    @concepts, @filenames, @contexts = get_lists_from(concepts)
    @image_urls = find_url_images_from_internet(show_progress)
  end

  ##
  # For every concept... find its neighbors
  # @param concepts (Array)
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

  # rubocop:disable Metrics/MethodLength
  def get_lists_from(input)
    concepts = {}
    filenames = []
    contexts = []
    input.each do |c|
      next unless c.process

      concepts[c.name] = c
      filenames << c.filename
      contexts  << c.context
    end
    filenames.uniq!
    contexts.uniq!
    [concepts, filenames, contexts]
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def find_url_images_from_internet(show_progress)
    return {} unless Application.instance.config['global']['internet'] == 'yes'

    Logger.verbose "\n[INFO] Loading data from Internet" if show_progress
    threads = []
    searchs = []
    urls = {}

    @concepts&.each_key { |key| searchs << key }
    @contexts.each { |filter| searchs << filter.join(' ').to_s }
    searchs.each do |search|
      Logger.verbose('.') if show_progress
      threads << Thread.new { urls[search] = ImageUrlLoader.load(search) }
    end
    threads.each(&:join) # wait for all threads to finish
    Logger.verbose("\n") if show_progress
    urls
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
