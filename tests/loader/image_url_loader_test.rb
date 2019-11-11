#!/usr/bin/ruby

require 'minitest/autorun'
require_relative '../../lib/asker/loader/image_url_loader'

class ImageUrlLoaderTest < Minitest::Test

  def setup
    @filters  = [ 'obiwan', 'yoda', ['character', 'starwars'] ]
  end

  def test_load
    @filters.each do |filter|
      urls = ImageUrlLoader::load(filter)
      assert_equal Array, urls.class
      i = 20
      i = 0 unless Application.instance.config['global']['internet'] == 'yes'
      assert_equal i, urls.size
    end
  end
end
